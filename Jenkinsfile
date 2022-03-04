pipeline {
agent any
    stages {       
        stage('Checkout') {
            steps {
                script {
                    try {
                        if (ci_branches.contains(env.BRANCH_NAME)) {
                            // Pull the code from bitbucket repository
                            checkout scm
                        }
                    }
                    catch(all) {
                        currentBuild.result='FAILURE'
                    }   
                }
            }
        }        
    }
}