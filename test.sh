#!/bin/bash
vLINE="######################################################################"
vTASK="TEST-${1}"
echo "${vLINE}"
echo "${vTASK} Started"

s=$((1 + $RANDOM % 10))
echo "Sleeping ... ${s} seconds"
sleep ${s}

r=$((1 + $RANDOM % 100))
echo "${vTASK} Completed"
echo "${vTASK} Result ${r}"

if [ ${r} -gt 5 ]; then
	echo "${vTASK} SUCCESSS" ; echo "${vLINE}" ; exit 0
else
	echo "${vTASK} FAILED"; echo "${vLINE}" ; exit 1
fi
