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
                }
                echo "RAO_TEAMS: ${RAO_TEAMS}"
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
                echo "Building team-earth started"
                script {
                    TEAM="team-earth"
                }
                echo "Building team-earth completed"
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
        stage('stage5-test2') {
            steps {
		sh "./test2.sh"
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
        stage('stage8') {
            when {
                expression { v_1 == 'value-1' }
            }
            steps {
                echo "v_1: ${v_1}"
            }
        }
        // ######################################################################
        stage('stage9') {
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
