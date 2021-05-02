#!/bin/bash
source myapp.env
vTYPE="${1}"
vTEAM="${2}"
vTASK="BUILD:${vTYPE}-${vTEAM}"
ECHO "${vLINE}"
ECHO "${vTASK} Started"

ECHO "Contents of ${BUILD_ENV_FILE}"
cat ${BUILD_ENV_FILE}

s=$((1 + $RANDOM % ${RC_SLEEP_SECONDS}))
echo "Sleeping ... ${s} seconds"
sleep ${s}

r=$((1 + $RANDOM % 100))
ECHO "${vTASK} Completed"
ECHO "${vTASK} Result ${r}"

if [ ${r} -gt ${RC_PASS_SCORE} ]; then
	ECHO "${vTASK} SUCCESSS" ; echo "${vLINE}" ; exit 0
else
	ECHO "${vTASK} FAILED"; echo "${vLINE}" ; exit 1
fi
