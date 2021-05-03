# ######################################################################
# Delete All CI/CD Jenkins jobs
# ######################################################################
#
./jenkins-cli.sh delete-job RAO-CI-10-Enter-Build
#
./jenkins-cli.sh delete-job RAO-CI-20-Build-Team-MARS
./jenkins-cli.sh delete-job RAO-CI-20-Build-Team-VENUS
./jenkins-cli.sh delete-job RAO-CI-20-Build-Team-PLUTO
#
./jenkins-cli.sh delete-job RAO-CI-30-Deploy-Team-MARS
./jenkins-cli.sh delete-job RAO-CI-30-Deploy-Team-VENUS
./jenkins-cli.sh delete-job RAO-CI-30-Deploy-Team-PLUTO
#
./jenkins-cli.sh delete-job RAO-CI-40-Test-Team-MARS
./jenkins-cli.sh delete-job RAO-CI-40-Test-Team-VENUS
./jenkins-cli.sh delete-job RAO-CI-40-Test-Team-PLUTO
#
./jenkins-cli.sh delete-job RAO-CI-50-System-Gate
./jenkins-cli.sh delete-job RAO-CI-51-Build-System
./jenkins-cli.sh delete-job RAO-CI-52-Deploy-System
./jenkins-cli.sh delete-job RAO-CI-53-Test-System
#
./jenkins-cli.sh delete-job RAO-CI-60-Release-Gate
./jenkins-cli.sh delete-job RAO-CI-61-Release-Prepare
./jenkins-cli.sh delete-job RAO-CI-62-Release-Verify
./jenkins-cli.sh delete-job RAO-CI-63-Release-Publish
./jenkins-cli.sh delete-job RAO-CI-64-Release-Notify
#
./jenkins-cli.sh delete-job RAO-CD-10-Deploy-Security-Test
./jenkins-cli.sh delete-job RAO-CD-20-Deploy-Performance-Test
./jenkins-cli.sh delete-job RAO-CD-30-Deploy-Acceptance-Test
./jenkins-cli.sh delete-job RAO-CD-40-Deploy-Interface-Test
./jenkins-cli.sh delete-job RAO-CD-50-Deploy-Production
#
./jenkins-cli.sh delete-view RAO-CI
./jenkins-cli.sh delete-view RAO-CD
#
# ######################################################################
