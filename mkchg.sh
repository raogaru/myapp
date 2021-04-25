TEAM=$1
CNT=$2
cd $HOME/GitHub/myapp
for i in 1..${CNT}
do
git checkout team-${TEAM}
echo "$(date) change ${CNT} by ${TEAM} in file ${TEAM}/${TEAM}.txt" >> ${TEAM}/${TEAM}.txt
done
git add ${TEAM}/${TEAM}.txt
git commit -m "RAO-${TEAM}:${TEAM}/${TEAM}.txt file added"
git push --set-upstream origin team-${TEAM}
