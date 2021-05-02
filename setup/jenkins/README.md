# ######################################################################
# Configure Jenkins server in preparation for CICD pipeline
# ######################################################################

# Installation instructions for  Jenkins Server for Mac 

https://www.jenkins.io/download/

brew install jenkins-lts

# Instllation instructions for Linux

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key

yum install jenkins

# Jenkins Home location

$HOME/.jenkins

# Start Jenkins

jenkins-lts

# get initial password for Jenkins login
cat  $HOME/.jenkins/secrets/initialAdminPassword
Password is: 82e6_PASSWORD_CHANGED_7e4a9f02a4

# open Jenkins in browser
http://localhost:8080/

# ######################################################################
# Configure Jenkins Jobs, Views and Pipelines
# ######################################################################

Step-1: Create new Jenkins job named "Generate-CI-CD-Jobs-using-JobDSL" 

	project = "Freestyle project"

	Choose "Git" as "Source Code Management"

	Repository URL: https://github.com/raogaru/myapp.git

	Add build step = "Process Job DSLs" 

	choose look on File system 

	enter setup/jenkins/CICD_jobs.groovy

Step-2: Build Job "Generate-CI-CD-Jobs-using-JobDSL"

Step-3: Above job will generate CI and CD jobs and views

