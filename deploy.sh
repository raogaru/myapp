#!/bin/bash
source myapp.env
vTARGET="${1}"
vTASK="DEPLOY:${vTARGET}"
echo "${vLINE}"
echo "${vTASK} Started"

echo Deploy to ${vTARGET} database
case " "${vTARGET}" in 
"PIPE") src/db/liquibase.sh pipe ;;
"SECURITY") src/db/liquibase.sh st ;;
"PERFORMANCE") src/db/liquibase.sh pt ;;
"ACCEPTANCE") src/db/liquibase.sh at ;;
"INTERFACE") src/db/liquibase.sh it ;;
"PRODUCTION") src/db/liquibase.sh prod ;;
esac

s=$((1 + $RANDOM % ${RC_SLEEP_SECONDS}))
echo "Sleeping ... ${s} seconds"
sleep ${s}

r=$((1 + $RANDOM % 100))
echo "${vTASK} Completed"
echo "${vTASK} Result ${r}"

if [ ${r} -gt ${RC_PASS_SCORE} ]; then
	echo "${vTASK} SUCCESSS" ; echo "${vLINE}" ; exit 0
else
	echo "${vTASK} FAILED"; echo "${vLINE}" ; exit 1
fi
