#!/bin/bash
vLINE="######################################################################"
vTYPE="${1}"
vTEAM="${2}"
vTASK="BUILD:${vTYPE}-${vTEAM}"
echo "${vLINE}"
echo "${vTASK} Started"

#if [ "${vTYPE}" != "TEAM" ] && [ "${vTYPE}" != "SYSTEM" ] ; then
#	echo Invalid argument to build script
#	exit 1
#fi

#if [ "${vTYPE}" == "TEAM" ] ; then
#	vGITLOG="team-${vTEAM}.gitlog"
#fi

#if [ "${vTYPE}" == "SYSTEM" ] ; then
#vGITLOG="system.gitlog"
#fi

#git log origin/master..origin/team-${vTEAM} --pretty=format:"%ad:%h:%H:%an:%ae:%s" --date format:'%Y-%m-%d-%H-%M-%S' 
#> $}vGITLOG}
#cat ${vGITLOG}

s=$((1 + $RANDOM % 3))
echo "Sleeping ... ${s} seconds"
sleep ${s}

r=$((1 + $RANDOM % 100))
echo "${vTASK} Completed"
echo "${vTASK} Result ${r}"

if [ ${r} -gt 1 ]; then
	echo "${vTASK} SUCCESSS" ; echo "${vLINE}" ; exit 0
else
	echo "${vTASK} FAILED"; echo "${vLINE}" ; exit 1
fi
