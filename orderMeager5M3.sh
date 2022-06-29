CURRENT=`date +"%Y%m%d"  --date='+2 day'`
PREVIOUS=`date +"%Y%m%d" --date='-2 day'`

python eodms-cli/eodms_cli.py \
    -c RCMImageProducts \
    -d PREVIOUS-CURRENT \
    -i eodms-cli/AOIs/A4201_Volcano_Meager.shp \
    -prc full \
    -ov 50 \
    -f "RCMImageProducts.BEAM_MNEMONIC=5M3" \
    -o eodms-cli/output_geospatial/output.shp \
    -pri high -s

for file in downloads/*zip
do 
  aws s3 mv $file s3://vrrc-rcm-raw-data-store/Meager/5M3/
done
