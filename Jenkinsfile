
// pipeline {
//    agent any
//    stages {
//       stage('deploy') {
//          steps {
//             echo 'Deploying....'
//             sh "pwd"
//             sh "ls"
//          }
//       }
//    }
// }

def dockerTag = "abc"

podTemplate (yaml: """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: docker
    image: docker:latest
    workingDir: /var/jenkins_home
    command: ['cat']
    tty: true
    volumeMounts:
    - name: dockersock
      mountPath: /var/run/docker.sock   
  - env:
    - name: "JENKINS_AGENT_WORKDIR"
      value: "/var/jenkins_home"    
  volumes:
  - name: dockersock
    hostPath:
      path: /var/jenkins_home
"""
  ){
    
    node(POD_LABEL) {
        stage('Run shell') {
            sh "pwd"
            sh "ls" 
            container('docker') {
            sh "pwd"
            sh "ls"    
            sh "docker build -t 0352730247/node-app:${dockerTag} ."
                
            withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                sh "docker login -u 0352730247 -p ${dockerHubPwd}"
            }
                
            sh "docker push 0352730247/node-app:${dockerTag}"
            }
        }
    }
}

def getLatestCommitId(){
	def commitId = sh returnStdout: true, script: 'git rev-parse HEAD'
	return commitId
}

