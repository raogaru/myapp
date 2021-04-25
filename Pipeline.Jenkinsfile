#!/usr/bin/env groovy
pipeline {
    agent any
    
     options {
        timestamps()
    }

    environment {
        RAO_TEAMS = "earth mars venus"
    }

    stages {
        // ######################################################################
        stage('stage1') {
            steps {
                script {
                    v_1 = "value-1"
                    sh "find . -type f -print"
                    /*for TEAM_NAME in ${RAO_TEAMS}
                    do
                    
                    done
                    */
                }
                echo "v_1: ${v_1}"
            }
        }
        // ######################################################################
        stage('stage2') {
            steps {
                script {
                    v_1 = "value-1"
                }
                echo "v_1: ${v_1}"
            }
        }
        // ######################################################################
        stage('stage3') {
            steps {
                script {
                    v_2="value-2"
                }
                echo "v_1: ${v_1}"
            }
        }
        // ######################################################################
        stage('stage4') {
            when {
                expression { v_1 != 'value-1' }
            }
            steps {
                echo "v_2: ${v_2}"
            }
        }
        // ######################################################################
        stage('stage5') {
            when {
                expression { v_1 == 'value-1' }
            }
            steps {
                echo "v_1: ${v_1}"
            }
        }
        // ######################################################################
        stage('stage6') {
            when {
                expression { v_1 == 'value-1' }
            }
            steps {
                echo "v_1: ${v_1}"
            }
        }
        // ######################################################################
        stage('stage7') {
            when {
                expression { v_1 == 'value-1' }
            }
            steps {
                echo "v_1: ${v_1}"
            }
        }
        // ######################################################################
    }
}
