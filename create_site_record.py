import argparse
import configparser
import json
import requests

def main():

    args = parse_args()
    config = get_config_params("/home/ec2-user/eodms-cli/config.ini")

    # Check if the target exists

    response = requests.get(f'http://10.70.137.99/targets/{args.label}')

    # if the target doesnt exist post it
    if response.content == b'{"detail":"Target not found"}':
        f = open(f'AOIs/{args.label}.json')
        data = json.load(f)
        coordinates = data['features'][0]['geometry']['coordinates'][0]
        # Remove height value in coordinate list
        for coord in coordinates:
            coord.pop()
        json_content={
                                "label": args.label,
                                "name_en": args.name_en,
                                "name_fr": args.name_fr,
                                "geometry": {
                                    "type": "Polygon",
                                    "coordinates": [coordinates]
                                }
                            }

        response = requests.post('http://10.70.137.99/targets',
                                 json=json_content)
        return response.content


def get_config_params(args):
    """
    Parse Input/Output columns from supplied *.ini file
    """
    configParseObj = configparser.ConfigParser()
    configParseObj.read(args)
    return configParseObj


def parse_args():
    parser = argparse.ArgumentParser(description=(""))
    parser.add_argument("--site",
                        type=str,
                        help='Volcanic Site Name',
                        required=True)
    parser.add_argument("--label",
                        type=str,
                        help='Name of site label, same format as AOI kml',
                        required=True)
    parser.add_argument("--name_en",
                        type=str,
                        help='Volcano Name in english',
                        required=True)
    parser.add_argument("--name_fr",
                        type=str,
                        help='Volcano Name in french',
                        required=True)
    args = parser.parse_args()

    return args


if __name__ == '__main__':
    main()
