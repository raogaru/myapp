#!/bin/bash

vACTION=${1}

source myapp.env

BUILD_ENV_FILE=/tmp/build.env
BUILD_TEAMS="earth mars venus"
v_debug=1
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
f_flow_init() {
rm -f ${BUILD_ENV_FILE}
touch ${BUILD_ENV_FILE}
chmod 755 ${BUILD_ENV_FILE}
BUILD_NUM=$(date '+%Y%m%d%H%M')
UpdateEnvFile "BUILD_NUM=${BUILD_NUM}"
echo ${vLINE}
ECHO "Build Initialized - BUILD_NUM is \"${BUILD_NUM}\""
echo ${vLINE}
mkdir -p /tmp/${BUILD_NUM}
}
# ------------------------------------------------------------
f_flow_checkout_master() {
ECHO "Checkout master branch"
	git checkout master

LineHeader "List all branches"
	git branch -a

LineHeader "Current branch"
	x1=$(git branch | grep "^\*" | sed -e 's/^\* //')
	[[ "${x1}" != "master" ]] && ERROR "Current branch is not \"master\"."
}
# ------------------------------------------------------------
f_flow_validate_team_branches() {
LineHeader "List development teams"
	rm -f /tmp/${BUILD_NUM}/teams.tmp
	for TEAM in ${BUILD_TEAMS}; do echo "${TEAM}" >> /tmp/${BUILD_NUM}/teams.tmp; done
	cat /tmp/${BUILD_NUM}/teams.tmp |sort > /tmp/${BUILD_NUM}/teams.lst
	cat /tmp/${BUILD_NUM}/teams.lst
	rm -f /tmp/${BUILD_NUM}/teams.tmp

LineHeader "Identify list of team-branches"
	git branch -a | grep remote | grep "\/team\-" | sed -e 's/^.*\/team-//'|sort > /tmp/${BUILD_NUM}/git_team_branches.lst
	cat /tmp/${BUILD_NUM}/git_team_branches.lst | sed -e 's/^/team\-/'

LineHeader "Compare teams with team-branches"
	diff /tmp/${BUILD_NUM}/teams.lst /tmp/${BUILD_NUM}/git_team_branches.lst
	r=$?

if [ $r -eq 0 ]; then
	ECHO "team and team-branches match"
else
	WARN "team and team-branches match"

	LineHeader "Team branches missing. Branches to be created: "
	diff /tmp/${BUILD_NUM}/teams.lst /tmp/${BUILD_NUM}/git_team_branches.lst |grep "<" |sed -e 's/^\< //'| sed -e 's/^/team\-/'

	LineHeader "Team branches found for unknown team. Branches to be deleted:"
	diff /tmp/${BUILD_NUM}/teams.lst /tmp/${BUILD_NUM}/git_team_branches.lst |grep ">" |sed -e 's/^\> //' | sed -e 's/^/team\-/'
fi
}
# ------------------------------------------------------------
f_flow_list_commits_by_each_team () {
ECHO ${vLINE}
ECHO "Compare team branch \"team-${TEAM}\" with build branch \"build-${TEAM}\""
for TEAM in ${BUILD_TEAMS}
do
	LineHeader "List of commits by team \"${TEAM}\":"
	ECHO "git log origin/master..build-${TEAM}" 
	git log origin/master..origin/team-${TEAM} --pretty=format:"%ad:%h:%H:%an:%ae:%s" --date format:'%Y-%m-%d-%H-%M-%S' 
	git log origin/master..origin/team-${TEAM} --pretty=format:"%ad:%h:%H:%an:%ae:%s" --date format:'%Y-%m-%d-%H-%M-%S'  > /tmp/${BUILD_NUM}/git_commits_by_${TEAM}.lst
done
}
# ------------------------------------------------------------
# Drop and recreate build branches 
#Why?: Agile teams can continue to check-in code into team branches while pipeline uses a snapshot of team branch in the name of build branch"
# ------------------------------------------------------------
f_flow_drop_build_branches () {
LineHeader "Drop build branches"
for TEAM in ${BUILD_TEAMS}
do
	ECHO "Drop branch \"build-${TEAM}\"" 
	git branch -D build-${TEAM}
	r=$?
	if [ $r -ne 0 ]; then
		WARN "git branch -D build-${TEAM} failed"
	fi
done
}
# ------------------------------------------------------------
f_flow_recreate_build_branches () {
LineHeader "Create build branches"
git checkout master
for TEAM in ${BUILD_TEAMS}
do
	ECHO "Create branch \"build-${TEAM}\"" 
	git branch build-${TEAM}
	r=$?
	if [ $r -ne 0 ]; then
		WARN "git branch build-${TEAM} failed"
	fi
done
}
# ------------------------------------------------------------
f_flow_merge_team_branches_to_build_branches () {
LineHeader "Merge team branches into build branches." 
for TEAM in ${BUILD_TEAMS}
do
	LineHeader "Merge team branch \"team-${TEAM}\" into \"build-${TEAM}\""
	git checkout build-${TEAM}
	r=$?
	if [ $r -ne 0 ]; then
		WARN "git checkout build-${TEAM} failed"
	fi
	git merge team-${TEAM} -m "merge-by-build-flow-${BUILD_NUM}"
	r=$?
	if [ $r -ne 0 ]; then
		WARN "git merge build-${TEAM} failed"
	fi
done
}
# ------------------------------------------------------------
######################################################################
# MAIN PROGRAM
######################################################################
f_flow_init
f_flow_checkout_master
f_flow_validate_team_branches
f_flow_list_commits_by_each_team
f_flow_drop_build_branches
f_flow_recreate_build_branches
f_flow_drop_and_recreate_build_branches

git checkout master
LineHeader "Checkout master" 

LineHeader "Completed."
