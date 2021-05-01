######################################################################
# Configure Jenkins Jobs, Views and Pipelines
######################################################################

Step-1: Create new Jenkins job named "Generate-CI-CD-using-JobDSL" using "Freestyle project" using "Process Job DSLs" build-step and use the code in CICD-jobs.JobDSL

Step-2: Execute Job "Generate-CI-CD-using-JobDSL"

Step-3: Create new Jenkins job named "RAO-CI-00-pipeline" usinga "Pipeline"  option with pipeline script code from myapp.git/CI-pipeline.JobDSL

Step-4: Create new Jenkins job named "RAO-CD-00-pipeline" usinga "Pipeline"  option with pipeline script code from myapp.git/CD-pipeline.JobDSL

Step-5: Above job will generate CI and CD jobs and views

