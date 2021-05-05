#!/bin/bash
# ######################################################################
# CI Build Git Flow
# ######################################################################
vACTION=${1}
source myapp.env
# ------------------------------------------------------------
f_teamgate_init() {
rm -f ${BUILD_ENV_FILE}
touch ${BUILD_ENV_FILE}
chmod 755 ${BUILD_ENV_FILE}
export PIPE_NUM=$(date '+%Y%m%d%H%M')
ADDENV "PIPE_NUM=${PIPE_NUM}"
PIPE_DIR=/tmp/build/${PIPE_NUM}
ADDENV "PIPE_DIR=${PIPE_DIR}"
ADDENV "AGILE_TEAMS=\"${AGILE_TEAMS}\""
ECHO ${vLINE}
ECHO "Build Initialized - PIPE_NUM is \"${PIPE_NUM}\""
ECHO ${vLINE}
mkdir -p ${PIPE_DIR}
}
# ------------------------------------------------------------
f_teamgate_checkout_master() {
ECHO "Checkout master branch"
	git checkout master

HEADER "List all branches"
	git branch -a

HEADER "Current branch"
	x1=$(git branch | grep "^\*" | sed -e 's/^\* //')
	[[ "${x1}" != "master" ]] && ERROR "Current branch is not \"master\"."
}
# ------------------------------------------------------------
f_teamgate_validate_team_branches() {
HEADER "List development teams"
	rm -f ${PIPE_DIR}/teams.tmp
	for TEAM in ${AGILE_TEAMS}; do echo "${TEAM}" >> ${PIPE_DIR}/teams.tmp; done
	cat ${PIPE_DIR}/teams.tmp |sort > ${PIPE_DIR}/teams.lst
	cat ${PIPE_DIR}/teams.lst
	rm -f ${PIPE_DIR}/teams.tmp

HEADER "Identify list of team-branches"
	git branch -a | grep remote | grep "\/team\-" | sed -e 's/^.*\/team-//'|sort > ${PIPE_DIR}/git_team_branches.lst
	cat ${PIPE_DIR}/git_team_branches.lst | sed -e 's/^/team\-/'

HEADER "Compare teams with team-branches"
	diff ${PIPE_DIR}/teams.lst ${PIPE_DIR}/git_team_branches.lst
	r=$?

if [ $r -eq 0 ]; then
	ECHO "team and team-branches match"
else
	WARN "team and team-branches does not match"

	HEADER "Team branches missing. Branches to be created: "
	diff ${PIPE_DIR}/teams.lst ${PIPE_DIR}/git_team_branches.lst |grep "<" |sed -e 's/^\< //'| sed -e 's/^/team\-/'

	HEADER "Team branches found for unknown team. Branches to be deleted:"
	diff ${PIPE_DIR}/teams.lst ${PIPE_DIR}/git_team_branches.lst |grep ">" |sed -e 's/^\> //' | sed -e 's/^/team\-/'
fi
}
# ------------------------------------------------------------
f_teamgate_list_commits_by_each_team () {
ECHO ${vLINE}
ECHO "Compare team branch \"team-${TEAM}\" with build branch \"build-${TEAM}\""
for TEAM in ${AGILE_TEAMS}
do
	echo ''
	HEADER "List of commits by team \"${TEAM}\":"
	ECHO "git log origin/master..build-${TEAM}" 
	git log origin/master..origin/team-${TEAM} --pretty=format:"%ad:%h:%H:%an:%ae:%s" --date format:'%Y-%m-%d-%H-%M-%S' 
	git log origin/master..origin/team-${TEAM} --pretty=format:"%ad:%h:%H:%an:%ae:%s" --date format:'%Y-%m-%d-%H-%M-%S'  > ${PIPE_DIR}/git_commits_by_${TEAM}.lst
	[[ -s ${PIPE_DIR}/git_commits_by_${TEAM}.lst ]] && ADDENV "TEAM_COMMITS_${TEAM}=YES"
done
}
# ------------------------------------------------------------
# Drop,recreate build branches and then merge team branches to build branches
#Why?: Agile teams can continue to check-in code into team branches while pipeline uses a snapshot of team branch in the name of build branch"
# ------------------------------------------------------------
f_teamgate_drop_build_branches () {
HEADER "Drop build branches"
for TEAM in ${AGILE_TEAMS}
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
f_teamgate_recreate_build_branches () {
HEADER "Create build branches"
git checkout master
for TEAM in ${AGILE_TEAMS}
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
f_teamgate_merge_team_branches_to_build_branches () {
HEADER "Merge team branches into build branches." 
for TEAM in ${AGILE_TEAMS}
do
	HEADER "Merge team branch \"team-${TEAM}\" into \"build-${TEAM}\""
	git checkout build-${TEAM}
	r=$?
	if [ $r -ne 0 ]; then
		WARN "git checkout build-${TEAM} failed"
	fi
	git merge origin/team-${TEAM} -m "merge-by-Team-Gate-flow-${PIPE_NUM}"
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
f_teamgate_init
f_teamgate_checkout_master
f_teamgate_validate_team_branches
f_teamgate_list_commits_by_each_team
f_teamgate_drop_build_branches
f_teamgate_recreate_build_branches
f_teamgate_merge_team_branches_to_build_branches

git checkout master
HEADER "Checkout master" 

HEADER "Completed."
#
# ######################################################################
#
