vLINE="######################################################################"
vTEST="TEST{1}"
echo "${vLINE}"
echo "${vTEST} Started"

s=$((1 + $RANDOM % 10))
echo "Sleeping ... ${s} seconds"
sleep ${s}

r=$((1 + $RANDOM % 100))
echo "${vTEST} Completed"
echo "${vTEST} Result ${r}"

if [ ${r} -gt 5 ]; then
	echo "${vTEST} SUCCESSS" ; echo "${vLINE}" ; exit 0
else
	echo "${vTEST} FAILED"; echo "${vLINE}" ; exit 1
fi
