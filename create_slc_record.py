
import argparse
import os
import requests
import zipfile

from lxml import etree as ET


def main():
    # Parse Arguments
    args = parse_args()
    # Read and parse xml metadata directly from zip file
    zip_file = zipfile.ZipFile(args.image_file_name, 'r')
    product_filepath = os.path.join(
        os.path.splitext(os.path.basename(args.image_file_name))[0],
        'metadata',
        'product.xml').replace('\\', '/')
    xml_file = zip_file.open(product_filepath)
    tree = ET.parse(xml_file)
    root = tree.getroot()
    namespace = {'ns': 'rcmGsProductSchema'}

    # Populate SLC matadata and create body to post to API
    product_uri = '/'.join(['s3://vrrc-rcm-raw-data-store',
                           args.site,
                           args.beam,
                           args.image_file_name])
    data_start_time = root.find('.//ns:rawDataStartTime', namespace).text
    footprint = get_slc_corners(root, tree, namespace)
    specaial_handling_bool = root.find('.//ns:specialHandlingRequired',
                                       namespace).text
    beam_id = get_beam_id_from_api(args)

    slc_body = {
        "product_uri": product_uri,
        "beam_id": beam_id,
        "source_url": None,
        "data_start_time": data_start_time,
        "status": "new",
        "status_info": None,
        "footprint": footprint,
        "special_handling_required": specaial_handling_bool
    }
    response = requests.post('http://localhost:8081/slc/', json=slc_body)
    return response.status_code


def get_slc_corners(root, tree, namespace):
    lines = "{:.7e}".format(int(root.find('.//ns:numLines', namespace).text)-1)
    samplesPerLine = "{:.7e}".format(int(root.find('.//ns:samplesPerLine', namespace).text)-1)
    # find 4 corner coordinates, so lat/long at [0,0], [0,samplesPerLine], [lines,0], [lines,samplesPerLine]
    top_left = tree.xpath(".//ns:imageReferenceAttributes/"
                          "ns:geographicInformation/"
                          "ns:geolocationGrid/ns:imageTiePoint["
                          "ns:imageCoordinate/ns:line='0.0000000e+00' and "
                          "ns:imageCoordinate/ns:pixel='0.0000000e+00']",
                          namespaces=namespace)
    top_right = tree.xpath(".//ns:imageReferenceAttributes/ns:geographicInformation/"
                           "ns:geolocationGrid/ns:imageTiePoint["
                           "ns:imageCoordinate/ns:line='0.0000000e+00' and "
                           f"ns:imageCoordinate/ns:pixel='{samplesPerLine}']", namespaces=namespace)
    bottom_left = tree.xpath(".//ns:imageReferenceAttributes/ns:geographicInformation/"
                             "ns:geolocationGrid/ns:imageTiePoint["
                             f"ns:imageCoordinate/ns:line='{lines}' and "
                             f"ns:imageCoordinate/ns:pixel='0.0000000e+00']", namespaces=namespace)
    bottom_right = tree.xpath(".//ns:imageReferenceAttributes/ns:geographicInformation/"
                              "ns:geolocationGrid/ns:imageTiePoint["
                              f"ns:imageCoordinate/ns:line='{lines}' and "
                              f"ns:imageCoordinate/ns:pixel='{samplesPerLine}']", namespaces=namespace)
    footprint = {
        "footprint": {
            "type": "Polygon",
            "coordinates": [
              [
                [
                  float(top_left[0][1][1].text),
                  float(top_left[0][1][0].text)
                ],
                [
                  float(top_right[0][1][1].text),
                  float(top_right[0][1][0].text)
                ],
                [
                  float(bottom_right[0][1][1].text),
                  float(bottom_right[0][1][0].text)
                ],
                [
                  float(bottom_left[0][1][1].text),
                  float(bottom_left[0][1][0].text)
                ],
              ]
            ]
        }
    }
    return footprint


def get_beam_id_from_api(args):
    response = requests.get('http://localhost:8081/beams/')
    if response.status_code == 200:
        data_dict = response.json()
    for item in data_dict:
        if item['short_name'] == args.beam and args.site in item['target_label']:
            beam_id = int(item['id'])
    return beam_id


def parse_args():
    parser = argparse.ArgumentParser(description=("Create SLC Record in VRRC"
                                                  "database via API"))
    parser.add_argument("--site",
                        type=str,
                        help='Volcanic Site Name',
                        required=True)
    parser.add_argument("--beam",
                        type=str,
                        help="RCM Beam Mode",
                        required=True)
    parser.add_argument("--image_file_name",
                        type=str,
                        help="RCM Zipfile Name",
                        required=True)
    args = parser.parse_args()
    # args = parser.parse_args(['--site', 'Fagradalsfjall', '--beam', '5M9', '--image_file_name', '/home/ec2-user/eodms-cli/downloads/RCM3_OK2894345_PK2947746_1_5M9_20240219_185609_HH_SLC.zip'])

    return args


if __name__ == '__main__':
    main()
