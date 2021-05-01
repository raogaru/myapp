######################################################################
# Documentation for configuring CICD pipeline
######################################################################

Step-1: Configure Git using instructions provided in setup/git/README.md

Step-2: Configure PostgreSQL using instructions provided in setup/postgres/README.md

Step-3: Configure Liquibase using instructions provided in setup/liquibase/README.md

Step-4: Configure Jenkins Server using instructions provided in setup/jenkins/README.md

Step-5: Configure Jenkins CI/CD jobs, views and pipelines using instructions provided in setup/jenkins/README.md 

Step-6: Simulate agile team member code check-ins using instructions provided in setup/checkin/README.md

Step-7: Run CI Pipeline job using instructions provided in setup/execute/README.md

Step-8: Run CD Pipeline job using instructions provided in setup/execute/README.md


######################################################################
# BUILD FLOW
######################################################################
# INIT GATE

Create build sequence number
BUILD_NUM=$(date '+%Y%m%d%H%M')

######################################################################
drop and recrate build-TEAM branches
for TEAM in <teams>
	git branch -D build-$TEAM
	git checkout master
	git branch build-$TEAM

######################################################################
TEAM CHECK GATE
merge team-<team> branch into build-<team>. devevelopers can continue check-in to team-branches after this step
for TEAM in <teams>
	git checkout build-$TEAM
	lock team-$TEAM branch
	git merge team-$TEAM
	unlock team-$TEAM branch
	if git merge failed - send notification to team
	if git merge success move to next step

######################################################################
TEAM BUILD GATE
compare master with <team> branch. If commits exists then follow
for TEAM in <teams>
	git log origin/master..origin/team-TEAM
	if commits found then mark v_team_commits=YES
	deploy build-team branch to <team> env
	if deploy successful mark v_team_deploy=SUCCESS
	test in <team> env
	if test successful mark v_team_test=SUCCESS

######################################################################
SYSTEM BUILD GATE
for TEAM in <teams> AND if commits found for team AND deploy sucessful AND test successful
	
for TEAM in <teams>
	if  v_team_commits=YES AND v_team_deploy=SUCCESS AND v_team_test=SUCCESS then
	merge build-<team> into build-system branch
	if anyone of team has commits, then 
	deploy build-system branch to <system> env
	if deploy successful mark v_system_deploy=SUCCESS
	test in <system> env
	if test successful mark v_system_test=SUCCESS

######################################################################
RELEASE GATE
if v_system_test=SUCCESS then
generate release number
generate release artifact
publish release artifacts: tar file, release notes

######################################################################
