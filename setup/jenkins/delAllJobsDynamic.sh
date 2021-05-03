#!/bin/bash

cat CICD_jobs.groovy | grep "^job" |sed -e "s/^job('//" | sed -e "s/') {//" | while read jobName
do
echo deleting job $jobName
./jenkins-cli.sh delete-job $jobName
done

#
# ######################################################################
