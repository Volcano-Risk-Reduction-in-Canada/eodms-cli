################################################################
# This script checks the EODMS Archive for new RCM imagery     #
# Collected within the past 2 days over each volcanic site     #
# If new imagery is found it is downloaded and sent to S3      #
# for storage. After downloading is complete a message is      #
# Generated for AWS SQS to queue InSAR processing of the       #
# new image with other recent images (SQS not yet implemented) #
################################################################

CURRENT=`date +"%Y%m%d"  --date='+2 day'`
PREVIOUS=`date +"%Y%m%d" --date='-1 day'`

###### A4201 Meager ######
BEAMS=(5M3 5M2 5M8 5M10 5M15 5M21)

for BEAM in ${BEAMS[@]};
do
  python3 ~/eodms-cli/eodms_cli.py \
      -c RCMImageProducts \
      -d ${PREVIOUS}-${CURRENT} \
      -i ~/eodms-cli/AOIs/A4201_Volcano_Meager.kml \
      -prc full \
      -ov 10 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  if ls ~/eodms-cli/downloads/*.zip &>/dev/null 
  then
    echo "RCM Images Downloaded"
    for file in ~/eodms-cli/downloads/*zip
    do
      date=${file#*$BEAM}
      date=${date:1:8}
      python3 ~/eodms-cli/create_slc_record.py \
        --site=Meager \
        --beam=$BEAM \
        --image_file_name=$file
      python3 ~/eodms-cli/createImageSqs.py \
        --site=Meager \
        --beam=${BEAM} \
        --imageDate=$date
      aws s3 mv $file s3://vrrc-rcm-raw-data-store/Meager/${BEAM}/
    done
  else
    echo "No Images Downloaded"
  fi
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
      -ov 10 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  if ls ~/eodms-cli/downloads/*.zip &>/dev/null 
  then
    echo "RCM Images Downloaded"
    for file in ~/eodms-cli/downloads/*zip
    do
      date=${file#*$BEAM}
      date=${date:1:8}
      python3 ~/eodms-cli/create_slc_record.py \
        --site=Garibaldi \
        --beam=$BEAM \
        --image_file_name=$file
      python3 ~/eodms-cli/createImageSqs.py \
        --site=Garibaldi \
        --beam=${BEAM} \
        --imageDate=$date
      aws s3 mv $file s3://vrrc-rcm-raw-data-store/Garibaldi/${BEAM}/
    done
  else
    echo "No Images Downloaded"
  fi
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
      -ov 10 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  if ls ~/eodms-cli/downloads/*.zip &>/dev/null 
  then
    echo "RCM Images Downloaded"
    for file in ~/eodms-cli/downloads/*zip
    do
      date=${file#*$BEAM}
      date=${date:1:8}
      python3 ~/eodms-cli/create_slc_record.py \
        --site=Cayley \
        --beam=$BEAM \
        --image_file_name=$file
      python3 ~/eodms-cli/createImageSqs.py \
        --site=Cayley \
        --beam=${BEAM} \
        --imageDate=$date
      aws s3 mv $file s3://vrrc-rcm-raw-data-store/Cayley/${BEAM}/
    done
  else
    echo "No Images Downloaded"
  fi
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
      -ov 10 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  if ls ~/eodms-cli/downloads/*.zip &>/dev/null 
  then
    echo "RCM Images Downloaded"
    for file in ~/eodms-cli/downloads/*zip
    do
      date=${file#*$BEAM}
      date=${date:1:8}
      python3 ~/eodms-cli/create_slc_record.py \
        --site=Edziza_North \
        --beam=$BEAM \
        --image_file_name=$file
      python3 ~/eodms-cli/createImageSqs.py \
        --site=Edziza_North \
        --beam=${BEAM} \
        --imageDate=$date
      aws s3 mv $file s3://vrrc-rcm-raw-data-store/Edziza_North/${BEAM}/
    done
  else
    echo "No Images Downloaded"
  fi
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
      -ov 10 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  if ls ~/eodms-cli/downloads/*.zip &>/dev/null 
  then
    echo "RCM Images Downloaded"
    for file in ~/eodms-cli/downloads/*zip
    do
      date=${file#*$BEAM}
      date=${date:1:8}
      python3 ~/eodms-cli/create_slc_record.py \
        --site=Edziza_South \
        --beam=$BEAM \
        --image_file_name=$file
      python3 ~/eodms-cli/createImageSqs.py \
        --site=Edziza_South \
        --beam=${BEAM} \
        --imageDate=$date
      aws s3 mv $file s3://vrrc-rcm-raw-data-store/Edziza_South/${BEAM}/
    done
  else
    echo "No Images Downloaded"
  fi
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
      -ov 10 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  if ls ~/eodms-cli/downloads/*.zip &>/dev/null 
  then
    echo "RCM Images Downloaded"
    for file in ~/eodms-cli/downloads/*zip
    do
      date=${file#*$BEAM}
      date=${date:1:8}
      python3 ~/eodms-cli/create_slc_record.py \
        --site=Tseax \
        --beam=$BEAM \
        --image_file_name=$file
      python3 ~/eodms-cli/createImageSqs.py \
        --site=Tseax \
        --beam=${BEAM} \
        --imageDate=$date
      aws s3 mv $file s3://vrrc-rcm-raw-data-store/Tseax/${BEAM}/
    done
  else
    echo "No Images Downloaded"
  fi
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
      -ov 10 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  if ls ~/eodms-cli/downloads/*.zip &>/dev/null 
  then
    echo "RCM Images Downloaded"
    for file in ~/eodms-cli/downloads/*zip
    do
      date=${file#*$BEAM}
      date=${date:1:8}
      python3 ~/eodms-cli/create_slc_record.py \
        --site=Nazko \
        --beam=$BEAM \
        --image_file_name=$file
      python3 ~/eodms-cli/createImageSqs.py \
        --site=Nazko \
        --beam=${BEAM} \
        --imageDate=$date
      aws s3 mv $file s3://vrrc-rcm-raw-data-store/Nazko/${BEAM}/
    done
  else
    echo "No Images Downloaded"
  fi
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
      -ov 10 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  if ls ~/eodms-cli/downloads/*.zip &>/dev/null 
  then
    echo "RCM Images Downloaded"
    for file in ~/eodms-cli/downloads/*zip
    do
      date=${file#*$BEAM}
      date=${date:1:8}
      python3 ~/eodms-cli/create_slc_record.py \
        --site=Hoodoo \
        --beam=$BEAM \
        --image_file_name=$file
      python3 ~/eodms-cli/createImageSqs.py \
        --site=Hoodoo \
        --beam=${BEAM} \
        --imageDate=$date
      aws s3 mv $file s3://vrrc-rcm-raw-data-store/Hoodoo/${BEAM}/
    done
  else
    echo "No Images Downloaded"
  fi
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
      -ov 10 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  if ls ~/eodms-cli/downloads/*.zip &>/dev/null 
  then
    echo "RCM Images Downloaded"
    for file in ~/eodms-cli/downloads/*zip
    do
      date=${file#*$BEAM}
      date=${date:1:8}
      python3 ~/eodms-cli/create_slc_record.py \
        --site=Lava_fork \
        --beam=$BEAM \
        --image_file_name=$file
      python3 ~/eodms-cli/createImageSqs.py \
        --site=Lava_Fork \
        --beam=${BEAM} \
        --imageDate=$date
      aws s3 mv $file s3://vrrc-rcm-raw-data-store/Lava_Fork/${BEAM}/
    done
  else
    echo "No Images Downloaded"
  fi
done

# Edgecumbe
BEAMS=(3M36)

for BEAM in ${BEAMS[@]};
do
  python3 ~/eodms-cli/eodms_cli.py \
      -c RCMImageProducts \
      -d ${PREVIOUS}-${CURRENT} \
      -i ~/eodms-cli/AOIs/Volcano_Edgecumbe.kml
      -prc full \
      -ov 10 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  if ls ~/eodms-cli/downloads/*.zip &>/dev/null 
  then
    echo "RCM Images Downloaded"
    for file in ~/eodms-cli/downloads/*zip
    do
      date=${file#*$BEAM}
      date=${date:1:8}
      python3 ~/eodms-cli/create_slc_record.py \
        --site=Edgecumbe \
        --beam=$BEAM \
        --image_file_name=$file
      python3 ~/eodms-cli/createImageSqs.py \
        --site=Edgecumbe \
        --beam=${BEAM}D \
        --imageDate=$date
      aws s3 mv $file s3://vrrc-rcm-raw-data-store/Lava_Fork/${BEAM}D/
    done
  else
    echo "No Images Downloaded"
  fi
done

# Campi Flegrei
BEAMS=(5M4 5M18)

for BEAM in ${BEAMS[@]};
do
  python3 ~/eodms-cli/eodms_cli.py \
      -c RCMImageProducts \
      -d ${PREVIOUS}-${CURRENT} \
      -i ~/eodms-cli/AOIs/Volcano_Campi_Flegrei.kml \
      -prc full \
      -ov 10 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  if ls ~/eodms-cli/downloads/*.zip &>/dev/null
  then
    echo "RCM Images Downloaded"
    for file in ~/eodms-cli/downloads/*zip
    do
      date=${file#*$BEAM}
      date=${date:1:8}
      python3 ~/eodms-cli/create_slc_record.py \
        --site=Campi_Flegrei \
        --beam=$BEAM \
        --image_file_name=$file
      python3 ~/eodms-cli/createImageSqs.py \
        --site=Campi_Flegrei \
        --beam=${BEAM} \
        --imageDate=$date
      aws s3 mv $file s3://vrrc-rcm-raw-data-store/Campi_Flegrei/${BEAM}/
    done
  else
    echo "No Images Downloaded"
  fi
done

# Vesuvius
BEAMS=(5M2 5M20)

for BEAM in ${BEAMS[@]};
do
  python3 ~/eodms-cli/eodms_cli.py \
      -c RCMImageProducts \
      -d ${PREVIOUS}-${CURRENT} \
      -i ~/eodms-cli/AOIs/Volcano_Vesuvius.kml \
      -prc full \
      -ov 10 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  if ls ~/eodms-cli/downloads/*.zip &>/dev/null
  then
    echo "RCM Images Downloaded"
    for file in ~/eodms-cli/downloads/*zip
    do
      date=${file#*$BEAM}
      date=${date:1:8}
      python3 ~/eodms-cli/create_slc_record.py \
        --site=Vesuvius \
        --beam=$BEAM \
        --image_file_name=$file
      python3 ~/eodms-cli/createImageSqs.py \
        --site=Vesuvius \
        --beam=${BEAM} \
        --imageDate=$date
      aws s3 mv $file s3://vrrc-rcm-raw-data-store/Vesuvius/${BEAM}/
    done
  else
    echo "No Images Downloaded"
  fi
done

# Fagradalsfjall
BEAMS=(5M13 5M9 5M17 5M18 5M22 5M4)

for BEAM in ${BEAMS[@]};
do
  python3 ~/eodms-cli/eodms_cli.py \
      -c RCMImageProducts \
      -d ${PREVIOUS}-${CURRENT} \
      -i ~/eodms-cli/AOIs/Fagradalsfjall.kml \
      -prc full \
      -ov 10 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  if ls ~/eodms-cli/downloads/*.zip &>/dev/null
  then
    echo "RCM Images Downloaded"
    for file in ~/eodms-cli/downloads/*zip
    do
      date=${file#*$BEAM}
      date=${date:1:8}
      python3 ~/eodms-cli/create_slc_record.py \
        --site=Fagradalsfjall \
        --beam=$BEAM \
        --image_file_name=$file
      python3 ~/eodms-cli/createImageSqs.py \
        --site=Fagradalsfjall \
        --beam=${BEAM} \
        --imageDate=$date
      aws s3 mv $file s3://vrrc-rcm-raw-data-store/Fagradalsfjall/${BEAM}/
    done
  else
    echo "No Images Downloaded"
  fi
done

# Thompson River Valley
BEAMS=(3M14)

for BEAM in ${BEAMS[@]};
do
  python3 ~/eodms-cli/eodms_cli.py \
      -c RCMImageProducts \
      -d ${PREVIOUS}-${CURRENT} \
      -i ~/eodms-cli/AOIs/Thompson_River_Valley.kml \
      -prc full \
      -ov 10 \
      -f "RCMImageProducts.BEAM_MNEMONIC="${BEAM} \
      -pri high -s

  if ls ~/eodms-cli/downloads/*.zip &>/dev/null
  then
    echo "RCM Images Downloaded"
    for file in ~/eodms-cli/downloads/*zip
    do
      date=${file#*$BEAM}
      date=${date:1:8}
      python3 ~/eodms-cli/create_slc_record.py \
        --site=Thompson_River_Valley \
        --beam=$BEAM \
        --image_file_name=$file
      python3 ~/eodms-cli/createImageSqs.py \
        --site=Thompson_River_Valley \
        --beam=${BEAM} \
        --imageDate=$date
      aws s3 mv $file s3://vrrc-rcm-raw-data-store/Thompson_River_Valley/${BEAM}/
    done
  else
    echo "No Images Downloaded"
  fi
done
