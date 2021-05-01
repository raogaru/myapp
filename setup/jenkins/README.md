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

