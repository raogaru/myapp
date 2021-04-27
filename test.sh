echo "######################################################################"
echo "TEST $1 Started"

s=$((1 + $RANDOM % 10))
echo "Sleeping ... ${s} seconds"
sleep ${s}

r=$((1 + $RANDOM % 100))
echo "TEST $1 Completed"
echo "TEST result ${r}"

if [ ${r} -gt 5 ]; then
	echo Test SUCCESS
	echo "######################################################################"
	exit 0
else
	echo Test FAILED
	echo "######################################################################"
	exit 1
fi
