# ######################################################################
# Delete All CI/CD Jenkins jobs
# ######################################################################
#
./jenkins-cli.sh delete-job RAO-CI-00-Pipeline
./jenkins-cli.sh delete-job RAO-CI-10-Enter-Build
./jenkins-cli.sh delete-job RAO-CI-20-Team-Build
./jenkins-cli.sh delete-job RAO-CI-30-System-Build
./jenkins-cli.sh delete-job RAO-CI-40-Release-Build
./jenkins-cli.sh delete-job RAO-CI-50-Deploy-Pipeline-Test
./jenkins-cli.sh delete-job RAO-CI-55-Execute-Pipeline-Test
#
./jenkins-cli.sh delete-job RAO-CD-00-Pipeline
./jenkins-cli.sh delete-job RAO-CD-10-Deploy-Security-Test
./jenkins-cli.sh delete-job RAO-CD-20-Deploy-Performance-Test
./jenkins-cli.sh delete-job RAO-CD-30-Deploy-Acceptance-Test
./jenkins-cli.sh delete-job RAO-CD-40-Deploy-Interface-Test
./jenkins-cli.sh delete-job RAO-CD-50-Deploy-Production
#
./jenkins-cli.sh delete-view RAO-CI
./jenkins-cli.sh delete-view RAO-CD
#

