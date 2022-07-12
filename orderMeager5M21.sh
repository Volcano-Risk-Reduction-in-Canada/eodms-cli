CURRENT=`date +"%Y%m%d"  --date='+2 day'`
PREVIOUS=`date +"%Y%m%d" --date='-2 day'`

python3 ~/eodms-cli/eodms_cli.py \
    -c RCMImageProducts \
    -d ${PREVIOUS}-${CURRENT} \
    -i ~/eodms-cli/AOIs/A4201_Volcano_Meager.kml \
    -prc full \
    -ov 50 \
    -f "RCMImageProducts.BEAM_MNEMONIC=5M21" \
    -pri high -s

sudo chmod 777 downloads/*

for file in ~/eodms-cli/downloads/*zip
do
  aws s3 mv $file s3://vrrc-rcm-raw-data-store/Meager/5M21/
done
