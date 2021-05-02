#!/bin/bash
COMMAND_NAME=${1}
COMMAND_ARG=${2}
/usr/local/opt/openjdk@11/libexec/openjdk.jdk/Contents/Home/bin/java -jar /usr/local/Cellar/jenkins-lts/2.277.3/libexec/cli-2.277.3.jar  \
-s "http://localhost:8080/" -webSocket -auth rao:rao ${COMMAND_NAME} ${COMMAND_ARG}
