echo "BUILD $1 Started"

s=$((1 + $RANDOM % 10))
echo "Sleeping ... ${s} seconds"
sleep ${s}

r=$((1 + $RANDOM % 100))
echo "BUILD $1 Completed"

echo "BUILD result ${r}"

if [ ${r} -le 2 ]; then
	echo Test FAILED
	exit 1
else
	echo Test SUCCESS
	exit 0
fi