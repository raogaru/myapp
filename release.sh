#!/bin/bash
source myapp.env
vTYPE="${1}"
vTASK="RELEASE:${vTYPE}"
ECHO "${vLINE}"

ECHO "Contents of ${BUILD_ENV_FILE}"
cat ${BUILD_ENV_FILE} 

#if [ "${vTYPE}" == "team" ]; then
#	x=$(cat ${BUILD_ENV_FILE}|grep TEAM_COMMITS_${vTEAM}|cut -f2 -d"=")
#  	if [ "${x}" != "YES" ]; then
#		ECHO "No commits. No build needed"
#		ADDENV "TEAM_BUILD_${vTEAM}=N/A"
#		exit 0
#	fi
#fi

ECHO "${vTASK} Started"

s=$((1 + $RANDOM % ${RC_SLEEP_SECONDS}))
echo "Sleeping ... ${s} seconds"
sleep ${s}

r=$((1 + $RANDOM % 100))
ECHO "${vTASK} Completed"
ECHO "${vTASK} Result ${r}"

if [ ${r} -gt ${RC_PASS_SCORE} ]; then
	ECHO "${vTASK} SUCCESSS"
	echo "${vLINE}" 
	exit 0
else
	ECHO "${vTASK} FAILED"
	echo "${vLINE}" 
	exit 1
fi
# ######################################################################
