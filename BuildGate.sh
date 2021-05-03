#!/bin/bash
# ######################################################################
# CI Build Git Flow
# ######################################################################
vACTION=${1}
source myapp.env
# ------------------------------------------------------------
f_flow_init() {
rm -f ${BUILD_ENV_FILE}
touch ${BUILD_ENV_FILE}
chmod 755 ${BUILD_ENV_FILE}
BUILD_NUM=$(date '+%Y%m%d%H%M')
ADDENV "BUILD_NUM=${BUILD_NUM}"
BUILD_DIR=/tmp/build/${BUILD_NUM}
ADDENV "BUILD_DIR=${BUILD_DIR}"
ADDENV "BUILD_TEAMS=\"${BUILD_TEAMS}\""
ECHO ${vLINE}
ECHO "Build Initialized - BUILD_NUM is \"${BUILD_NUM}\""
ECHO ${vLINE}
mkdir -p ${BUILD_DIR}
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
	rm -f ${BUILD_DIR}/teams.tmp
	for TEAM in ${BUILD_TEAMS}; do echo "${TEAM}" >> ${BUILD_DIR}/teams.tmp; done
	cat ${BUILD_DIR}/teams.tmp |sort > ${BUILD_DIR}/teams.lst
	cat ${BUILD_DIR}/teams.lst
	rm -f ${BUILD_DIR}/teams.tmp

LineHeader "Identify list of team-branches"
	git branch -a | grep remote | grep "\/team\-" | sed -e 's/^.*\/team-//'|sort > ${BUILD_DIR}/git_team_branches.lst
	cat ${BUILD_DIR}/git_team_branches.lst | sed -e 's/^/team\-/'

LineHeader "Compare teams with team-branches"
	diff ${BUILD_DIR}/teams.lst ${BUILD_DIR}/git_team_branches.lst
	r=$?

if [ $r -eq 0 ]; then
	ECHO "team and team-branches match"
else
	WARN "team and team-branches does not match"

	LineHeader "Team branches missing. Branches to be created: "
	diff ${BUILD_DIR}/teams.lst ${BUILD_DIR}/git_team_branches.lst |grep "<" |sed -e 's/^\< //'| sed -e 's/^/team\-/'

	LineHeader "Team branches found for unknown team. Branches to be deleted:"
	diff ${BUILD_DIR}/teams.lst ${BUILD_DIR}/git_team_branches.lst |grep ">" |sed -e 's/^\> //' | sed -e 's/^/team\-/'
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
	git log origin/master..origin/team-${TEAM} --pretty=format:"%ad:%h:%H:%an:%ae:%s" --date format:'%Y-%m-%d-%H-%M-%S'  > ${BUILD_DIR}/git_commits_by_${TEAM}.lst
	[[ -s ${BUILD_DIR}/git_commits_by_${TEAM}.lst ]] && ADDENV "TEAM_COMMITS_${TEAM}=YES"
done
}
# ------------------------------------------------------------
# Drop,recreate build branches and then merge team branches to build branches
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
# ######################################################################
# MAIN PROGRAM
# ######################################################################
f_flow_init
f_flow_checkout_master
f_flow_validate_team_branches
f_flow_list_commits_by_each_team
f_flow_drop_build_branches
f_flow_recreate_build_branches
f_flow_merge_team_branches_to_build_branches

git checkout master
LineHeader "Checkout master" 

LineHeader "Completed."
#
# ######################################################################
#
