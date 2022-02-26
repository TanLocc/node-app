
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
    command: ['cat']
    tty: true
    volumeMounts:
    - name: dockersock
      mountPath: /var/run/docker.sock
  volumes:
  - name: dockersock
    hostPath:
      path: /var/run/docker.sock
"""
  ){
    
    node(POD_LABEL) {
        stage('Run shell') {
            sh "pwd"
            sh "ls" 
            git 'https://github.com/TanLocc/node-app.git'
            container('docker') {
              sh "npm config set registry https://registry.npmjs.org/"
              sh "docker build -t 0352730247/node-app:${dockerTag} ."
              // withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
              //     sh "docker login -u 0352730247 -p ${dockerHubPwd}"
              // }
                  
              // sh "docker push 0352730247/node-app:${dockerTag}"
            }
        }
    }
}

def getLatestCommitId(){
	def commitId = sh returnStdout: true, script: 'git rev-parse HEAD'
	return commitId
}

