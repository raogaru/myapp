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

Step-1: Create new Jenkins job named "Generate-CI-CD-using-JobDSL" using "Freestyle project" using "Process Job DSLs" build-step and use the code in CICD-jobs.JobDSL

Step-2: Execute Job "Generate-CI-CD-using-JobDSL"

Step-3: Create new Jenkins job named "RAO-CI-00-pipeline" usinga "Pipeline"  option with pipeline script code from myapp.git/CI-pipeline.JobDSL

Step-4: Create new Jenkins job named "RAO-CD-00-pipeline" usinga "Pipeline"  option with pipeline script code from myapp.git/CD-pipeline.JobDSL

Step-5: Above job will generate CI and CD jobs and views

