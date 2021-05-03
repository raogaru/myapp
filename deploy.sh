#!/bin/bash
source myapp.env
vTYPE="${1}"
vTEAM="${2}"
vTASK="DEPLOY:${vTYPE}-${vTEAM}"
echo "${vLINE}"
echo "${vTASK} Started"

case "${vTYPE}" in
"team")
	v_commits=$(cat ${BUILD_ENV_FILE}|grep TEAM_COMMITS_${vTEAM}|cut -f2 -d"=")
	v_build_status=$(cat ${BUILD_ENV_FILE}|grep TEAM_BUILD_${vTEAM}|cut -f2 -d"=")
	;;
"system")
	v_commits=$(cat ${BUILD_ENV_FILE}|grep SYSTEM_COMMITS|cut -f2 -d"=")
	v_build_status=$(cat ${BUILD_ENV_FILE}|grep SYSTEM_BUILD|cut -f2 -d"=")
	;;
"ENV")
	v_commits="YES"
	v_build_status="SUCCESS"
	;;
esac

DEBUG "v_commits=${v_commits}"
DEBUG "v_build_status=${v_build_status}"

if [ "${v_commits}" == "YES" ] && [ "${v_build_status}" == "SUCCESS" ]; then
	ECHO "Proceed with Deployment"
	v_deploy_flag="YES"
else
	v_deploy_flag="NO"
	ECHO "Skipping Deployment"
	echo "${vLINE}"
	exit 1
fi

case "${vTYPE}" in
"team") 
	src/db/liquibase.sh ${vTEAM} ;;
"system") 
	src/db/liquibase.sh system ;;
"ENV")
	case "${vTEAM}" in 
	"SECURITY") src/db/liquibase.sh st ;;
	"PERFORMANCE") src/db/liquibase.sh pt ;;
	"ACCEPTANCE") src/db/liquibase.sh at ;;
	"INTERFACE") src/db/liquibase.sh it ;;
	"PRODUCTION") src/db/liquibase.sh prod ;;
	esac
	;;
esac

r=$?

if [ ${r} -eq 0 ]; then
	ECHO "Liquibase Build successful."
	case "${vTYPE}" in
	"team") 
		ADDENV "TEAM_DEPLOY_${vTEAM}=SUCCESS"
		;;
	"system") 
		ADDENV "SYSTEM_DEPLOY=SUCCESS"
		;;
	"ENV") 
		ADDENV "CD_ENV_${vTEAM}=SUCCESS"
		;;
	esac
else
	ECHO "Liquibase Failed."
	case "${vTYPE}" in
	"team") 
		ADDENV "TEAM_DEPLOY_${vTEAM}=FAILED"
		;;
	"system") 
		ADDENV "SYSTEM_DEPLOY=FAILED"
		;;
	"ENV") 
		ADDENV "CD_ENV_${vTEAM}=FAILED"
		;;
	esac
fi

s=$((1 + $RANDOM % ${RC_SLEEP_SECONDS}))
echo "Sleeping ... ${s} seconds"
sleep ${s}

r=$((1 + $RANDOM % 100))
echo "${vTASK} Completed"
echo "${vTASK} Result ${r}"

if [ ${r} -gt ${RC_PASS_SCORE} ]; then
	echo "${vTASK} SUCCESSS"
	echo "${vLINE}"
	exit 0
else
	echo "${vLINE}"
	exit 1
fi
