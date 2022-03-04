pipeline {
  environment{
        dockerTag = getLatestCommitId()
        devIp = '18.188.78.207'
    }
  agent {
    kubernetes {
      label 'jenkins'
      defaultContainer 'jnlp'
      yaml """
apiVersion: v1
kind: Pod
metadata:
labels:
  component: ci
spec:
  # Use service account that can deploy to all namespaces
  serviceAccountName: jenkins-admin
  containers:
  - name: docker
    image: docker:latest
    command:
    - cat
    tty: true
    volumeMounts:
    - mountPath: /var/run/docker.sock
      name: docker-sock
  volumes:
    - name: docker-sock
      hostPath:
        path: /var/run/docker.sock
"""
}
    }
  stages {

    stage('Push') {
      steps {
        // git 'https://github.com/TanLocc/node-app.git'
        container('docker') {
         
          sh "docker build . -t 0352730247/node-app:${dockerTag}"
        }
      }
    }
    stage('Dev Deploy'){
            steps {
                sh "chmod +x changeTag.sh"
                sh "./changeTag.sh ${dockerTag}"
              
               sshagent(['server-keypair']) {
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@${devIp} rm -rf app-node"
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@${devIp} mkdir app-node"
                    sh "scp -o StrictHostKeyChecking=no services.yml node-app-pod.yml ubuntu@${devIp}:/home/ubuntu/app-node/"
                    sh "ssh ubuntu@${devIp} cd /home/ubuntu/app-node/"
                    script{
                        try {
                            sh "ssh ubuntu@${devIp}: kubectl apply -f app-node/"
                        } catch(error) {
                            sh "ssh ubuntu@${devIp}: kubectl create -f app-node/"
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