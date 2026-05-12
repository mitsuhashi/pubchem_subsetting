#!/bin/bash

UPDATE_DATE="2024-03-14"
FINAL_DESTINATION=/mnt/nas05/togodx/pubchem/${UPDATE_DATE}

cat /dev/null > ./run_all_${UPDATE_DATE}.log

chmod +x ./update_procedure.sh

nohup sh -c "date > ./run_all_${UPDATE_DATE}.log; ./update_procedure.sh ${FINAL_DESTINATION} &>> ./run_all_${UPDATE_DATE}.log; date >> ./run_all_${UPDATE_DATE}.log" &
