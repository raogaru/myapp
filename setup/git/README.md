# ######################################################################
# Configure GIT in preparation for CICD pipeline
# ######################################################################

# Clone myapp.git
mkdir -p $HOME/GitHub

cd $HOME/GitHub

git clone https://github.com/raogaru/myapp.git

git branch -a

export BUILD_TEAMS="mars venus pluto"

# create team branches
for TEAM in ${BUILD_TEAMS}; do git branch team-${TEAM}; done

# create build branches
for TEAM in ${BUILD_TEAMS}; do git branch build-${TEAM}; done

# create system gate branch
git branch system

# create user branches
for TEAM in ${BUILD_TEAMS}; do git branch user-${TEAM}1;  git branch user-${TEAM}2;  git branch user-${TEAM}3; done

# configure push for all team branches
for TEAM in ${BUILD_TEAMS} system; do git checkout team-${TEAM};  git push --set-upstream origin team-${TEAM}; done

# configure push for all build branches
for TEAM in ${BUILD_TEAMS} system; do git checkout build-${TEAM};  git push --set-upstream origin build-${TEAM}; done

# configure push for all system branch
git checkout system
git push --set-upstream origin system

# configure push for all user branches
for TEAM in ${BUILD_TEAMS} ; 
do 
git checkout user-${TEAM}1; 
git push --set-upstream origin user-${TEAM}1; 
git checkout user-${TEAM}2; 
git push --set-upstream origin user-${TEAM}2;
git checkout user-${TEAM}3;
git push --set-upstream origin user-${TEAM}3;
done


# configure dummy app files for simulation

git checkout master 

mkdir -p src/app/dummy

echo "hello world" > src/app/dummy/file_0.txt

git add src/app/dummy/file_0.txt

mkdir -p src/db/sql

echo "--hello world" > src/app/dummy/000.sql

git add src/db/sql/000.sql

git commit -m dummy-files

git push


