#!/bin/bash
source pipeline.env
vTARGET="${1}"
vTASK="DEPLOY:${vTARGET}"
echo "${vLINE}"
echo "${vTASK} Started"

s=$((1 + $RANDOM % ${SLEEP_SECONDS}))
echo "Sleeping ... ${s} seconds"
sleep ${s}

r=$((1 + $RANDOM % 100))
echo "${vTASK} Completed"
echo "${vTASK} Result ${r}"

if [ ${r} -gt ${PASS_SCORE} ]; then
	echo "${vTASK} SUCCESSS" ; echo "${vLINE}" ; exit 0
else
	echo "${vTASK} FAILED"; echo "${vLINE}" ; exit 1
fi
