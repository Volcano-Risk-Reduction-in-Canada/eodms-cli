################################################################
# This script checks the EODMS Archive for new RCM imagery     #
# Collected within the past 2 days over each volcanic site     #
# If new imagery is found it is downloaded and sent to S3      #
# for storage. After downloading is complete a message is      #
# Generated for AWS SQS to queue InSAR processing of the       #
# new image with other recent images (SQS not yet implemented) #
################################################################

CURRENT=`date +"%Y%m%d"  --date='+2 day'`
PREVIOUS=`date +"%Y%m%d" --date='-2 day'`

###### A4201 Meager ######

BEAMS=(5M3 5M2 5M8 5M10 5M15 5M21)

for BEAM in ${BEAMS[@]};
do
  python3 ~/eodms-cli/eodms_cli.py \
      -c RCMImageProducts \
      -d ${PREVIOUS}-${CURRENT} \
      -i ~/eodms-cli/AOIs/A4201_Volcano_Meager.kml \
      -prc full \
      -ov 50 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  sudo chmod 777 downloads/*

  for file in ~/eodms-cli/downloads/*zip
  do
    date=${file#*$BEAM}
    date=${date:1:8}
    python3 ~/eodms-cli/creatImageSqs.py \
      --site=Meager \
      --beam=${BEAM} \
      --imageDate=$date
    aws s3 mv $file s3://vrrc-rcm-raw-data-store/Meager/${BEAM}/
  done
done

# A4202 Garibaldi

BEAMS=(3M6 3M7 3M18 3M23 3M30 3M34 3M42)

for BEAM in ${BEAMS[@]};
do
  python3 ~/eodms-cli/eodms_cli.py \
      -c RCMImageProducts \
      -d ${PREVIOUS}-${CURRENT} \
      -i ~/eodms-cli/AOIs/A4202_Volcano_Garbld.kml \
      -prc full \
      -ov 50 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  sudo chmod 777 downloads/*

  for file in ~/eodms-cli/downloads/*zip
  do
    date=${file#*$BEAM}
    date=${date:1:8}
    python3 ~/eodms-cli/creatImageSqs.py \
      --site=Garibaldi \
      --beam=${BEAM} \
      --imageDate=$date
    aws s3 mv $file s3://vrrc-rcm-raw-data-store/Garibaldi/${BEAM}/
  done
done

# A4203 Cayley

BEAMS=(3M1 3M6 3M13 3M14 3M17 3M24 3M30 3M36)

for BEAM in ${BEAMS[@]};
do
  python3 ~/eodms-cli/eodms_cli.py \
      -c RCMImageProducts \
      -d ${PREVIOUS}-${CURRENT} \
      -i ~/eodms-cli/AOIs/A4203_Volcano_Cayley.kml \
      -prc full \
      -ov 50 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  sudo chmod 777 downloads/*

  for file in ~/eodms-cli/downloads/*zip
  do
    date=${file#*$BEAM}
    date=${date:1:8}
    python3 ~/eodms-cli/creatImageSqs.py \
      --site=Cayley \
      --beam=${BEAM} \
      --imageDate=$date
    aws s3 mv $file s3://vrrc-rcm-raw-data-store/Cayley/${BEAM}/
  done
done

# A4204 Edziza North

BEAMS=(3M13 3M41)

for BEAM in ${BEAMS[@]};
do
  python3 ~/eodms-cli/eodms_cli.py \
      -c RCMImageProducts \
      -d ${PREVIOUS}-${CURRENT} \
      -i ~/eodms-cli/AOIs/A4204_Volcano_Edz_N.kml \
      -prc full \
      -ov 50 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  sudo chmod 777 downloads/*

  for file in ~/eodms-cli/downloads/*zip
  do
    date=${file#*$BEAM}
    date=${date:1:8}
    python3 ~/eodms-cli/creatImageSqs.py \
      --site=Edziza_North \
      --beam=${BEAM} \
      --imageDate=$date
    aws s3 mv $file s3://vrrc-rcm-raw-data-store/Edziza_North/${BEAM}/
  done
done

# A4205 Edziza South

BEAMS=(3M12 3M31 3M42)

for BEAM in ${BEAMS[@]};
do
  python3 ~/eodms-cli/eodms_cli.py \
      -c RCMImageProducts \
      -d ${PREVIOUS}-${CURRENT} \
      -i ~/eodms-cli/AOIs/A4205_Volcano_Edz_S.kml \
      -prc full \
      -ov 50 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  sudo chmod 777 downloads/*

  for file in ~/eodms-cli/downloads/*zip
  do
    date=${file#*$BEAM}
    date=${date:1:8}
    python3 ~/eodms-cli/creatImageSqs.py \
      --site=Edziza_South \
      --beam=${BEAM} \
      --imageDate=$date
    aws s3 mv $file s3://vrrc-rcm-raw-data-store/Edziza_South/${BEAM}/
  done
done

# A4206 Tseax

BEAMS=(3M7 3M9 3M19 3M40)

for BEAM in ${BEAMS[@]};
do
  python3 ~/eodms-cli/eodms_cli.py \
      -c RCMImageProducts \
      -d ${PREVIOUS}-${CURRENT} \
      -i ~/eodms-cli/AOIs/A4206_Volcano_Tseax.kml \
      -prc full \
      -ov 50 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  sudo chmod 777 downloads/*

  for file in ~/eodms-cli/downloads/*zip
  do
    date=${file#*$BEAM}
    date=${date:1:8}
    python3 ~/eodms-cli/creatImageSqs.py \
      --site=Tseax \
      --beam=${BEAM} \
      --imageDate=$date
    aws s3 mv $file s3://vrrc-rcm-raw-data-store/Tseax/${BEAM}/
  done
done

# A4207 Nazko 

BEAMS=(3M9 3M20 3M31)

for BEAM in ${BEAMS[@]};
do
  python3 ~/eodms-cli/eodms_cli.py \
      -c RCMImageProducts \
      -d ${PREVIOUS}-${CURRENT} \
      -i ~/eodms-cli/AOIs/A4207_Volcano_Nazko.kml \
      -prc full \
      -ov 50 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  sudo chmod 777 downloads/*

  for file in ~/eodms-cli/downloads/*zip
  do
    date=${file#*$BEAM}
    date=${date:1:8}
    python3 ~/eodms-cli/creatImageSqs.py \
      --site=Nazko \
      --beam=${BEAM} \
      --imageDate=$date
    aws s3 mv $file s3://vrrc-rcm-raw-data-store/Nazko/${BEAM}/
  done
done

# A4208 Hoodoo

BEAMS=(3M8 3M14 3M38 3M41 3M11)

for BEAM in ${BEAMS[@]};
do
  python3 ~/eodms-cli/eodms_cli.py \
      -c RCMImageProducts \
      -d ${PREVIOUS}-${CURRENT} \
      -i ~/eodms-cli/AOIs/A4208_Volcano_Hoodoo.kml \
      -prc full \
      -ov 50 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  sudo chmod 777 downloads/*

  for file in ~/eodms-cli/downloads/*zip
  do
    date=${file#*$BEAM}
    date=${date:1:8}
    python3 ~/eodms-cli/creatImageSqs.py \
      --site=Hoodoo \
      --beam=${BEAM} \
      --imageDate=$date
    aws s3 mv $file s3://vrrc-rcm-raw-data-store/Hoodoo/${BEAM}/
  done
done

# A4209 Lava Fork

BEAMS=(3M11 3M20 3M21 3M29 3M31 3M41)

for BEAM in ${BEAMS[@]};
do
  python3 ~/eodms-cli/eodms_cli.py \
      -c RCMImageProducts \
      -d ${PREVIOUS}-${CURRENT} \
      -i ~/eodms-cli/AOIs/A4209_Volcano_LavaFk.kml \
      -prc full \
      -ov 50 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  sudo chmod 777 downloads/*

  for file in ~/eodms-cli/downloads/*zip
  do
    date=${file#*$BEAM}
    date=${date:1:8}
    python3 ~/eodms-cli/creatImageSqs.py \
      --site=Lava_Fork \
      --beam=${BEAM} \
      --imageDate=$date
    aws s3 mv $file s3://vrrc-rcm-raw-data-store/Lava_Fork/${BEAM}/
  done
done

