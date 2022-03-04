pipeline {
  environment{
        dockerTag = getLatestCommitId()
        devIp = '18.188.78.207'
    }
  agent any
  stages {

    stage('Push') {
      steps {
        // git 'https://github.com/TanLocc/node-app.git'
        container('docker') {
         
          sh "docker build -t 0352730247/node-app:${dockerTag} ."
        }
      }
    }
    stage('Dev Deploy'){
            steps {
                sh "chmod +x changeTag.sh"
                sh "./changeTag.sh ${dockerTag}"
              script{
               sshagent(['server-keypair']) {
                 
                    sh "scp -o StrictHostKeyChecking=no services.yml node-app-pod.yml ubuntu@${devIp}:/home/ubuntu/"
                    
                        try {
                            sh "ssh ubuntu@${devIp} kubectl apply -f ."
                        } catch {
                            sh "ssh ubuntu@${devIp} kubectl create -f ."
                        }
                    }
                }
            }
  }
}

}

def getLatestCommitId(){
	def commitId = sh returnStdout: true, script: 'git rev-parse HEAD'
	return commitId
}