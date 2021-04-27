echo "######################################################################"
echo "TEST $1 Started"

s=$((1 + $RANDOM % 10))
echo "Sleeping ... ${s} seconds"
sleep ${s}

r=$((1 + $RANDOM % 100))
echo "TEST $1 Completed"

echo "TEST result ${r}"
echo "######################################################################"
if [ ${r} -le 5 ]; then
	echo Test FAILED
	exit 1
else
	echo Test SUCCESS
	exit 0
fi
