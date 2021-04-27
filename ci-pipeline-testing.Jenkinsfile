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
		shell('Test.sh 11')
		shell('Test.sh 12')
		shell('Test.sh 13')
		shell('Test.sh 14')
		shell('Test.sh 15')
            }
        }
        // ######################################################################
        stage('stage2') {
            steps {
		shell('Test.sh 21')
		shell('Test.sh 22')
		shell('Test.sh 23')
		shell('Test.sh 24')
		shell('Test.sh 25')
            }
        }
        // ######################################################################
        stage('stage3') {
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
