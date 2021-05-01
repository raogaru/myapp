#!/bin/bash
# ######################################################################
# This script is to simulate code check-in by different members of agile teams
# ######################################################################

vACTION=${1}

source myapp.env

MAX_FILE_COUNT=100		# max number of files edited by simulation
MIN_COMMITS_PER_TEAM=2		# min number of commits per team by simulation
MAX_COMMITS_PER_TEAM=5		# max number of commits per team by simulation
MAX_TEAM_MEMBERS=10		# max number of team members per agile team

BUILD_ENV_FILE=/tmp/build.env
v_debug=1
v_commits=0
vLINE="######################################################################"
vLINE2="----------------------------------------------------------------------"
# ------------------------------------------------------------
DEBUG () {
[[ ${v_debug} -gt 0 ]] && echo "$*"
}
# ------------------------------------------------------------
ECHO () {
echo "$*"
}
# ------------------------------------------------------------
ECHODO () {
echo "$*"
"$*"
}
# ------------------------------------------------------------
WARN () {
echo "WARNING:$*"
}
# ------------------------------------------------------------
ERROR () {
echo "ERROR:$*"; exit 1
}
# ------------------------------------------------------------
LineHeader () {
echo ${vLINE2}
echo "$*"
}
# ------------------------------------------------------------
UpdateEnvFile () {
echo "export $*" >> ${BUILD_ENV_FILE}
}
# ------------------------------------------------------------
f_checkin_code_by_team_members () {
ECHO "Simulate code check-in by each team "
for TEAM in ${BUILD_TEAMS}
do
	v_commits=$((1 + $RANDOM % ${MAX_COMMITS_PER_TEAM} ))
	[[ ${v_commits} -lt ${MIN_COMMITS_PER_TEAM} ]] && v_commits=${MIN_COMMITS_PER_TEAM}
	LineHeader "Team \"${TEAM}\" to perform \"${v_commits}\" commits"
	git checkout team-${TEAM}
	git merge master -m "merge master to team-${TEAM}"

	for ((i = 1 ; i <= ${v_commits} ; i++))
	do
		v_user=${TEAM}$((1 + $RANDOM % ${MAX_TEAM_MEMBERS}))
		v_jira="JIRA-"$((1000 + $RANDOM))
		v_file="src/app/dummy/file_"$((1 + $RANDOM % ${MAX_FILE_COUNT}))".txt"

		echo "$(date) change#${i} by user ${v_user} from team ${TEAM} in file ${v_file}" >> ${v_file}
		git add ${v_file}
		git commit -m "${v_jira}:${v_user}:${v_file} $(date)"
	done
	git push
done
}
# ------------------------------------------------------------
f_flow_list_commits_by_each_team () {
ECHO ${vLINE}
ECHO "Compare team branch \"team-${TEAM}\" with build branch \"build-${TEAM}\""
git checkout master
for TEAM in ${BUILD_TEAMS}
do
	LineHeader "List of commits by team \"${TEAM}\":"
	ECHO "git log origin/master..build-${TEAM}" 
	git log origin/master..team-${TEAM} --pretty=format:"%ad:%h:%H:%an:%ae:%s" --date format:'%Y-%m-%d-%H-%M-%S' 
done
}
######################################################################
# MAIN PROGRAM
######################################################################
f_checkin_code_by_team_members
f_flow_list_commits_by_each_team

LineHeader "Completed."

set -o vi
