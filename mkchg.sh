TEAM=$1
CNT=$2
cd $HOME/GitHub/myapp
git checkout team-${TEAM}
for i in 1..${CNT}
do
echo "$(date) change ${CNT} by ${TEAM} in file ${TEAM}/${TEAM}.txt" >> ${TEAM}/${TEAM}.txt
git add ${TEAM}/${TEAM}.txt
git commit -m "RAO-${TEAM}:${TEAM}/${TEAM}.txt file modified cnt=${CNT}"
done
git push --set-upstream origin team-${TEAM}
