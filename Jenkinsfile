// pipeline {
//   agent {
//     kubernetes {
//       label 'jenkins'
//       defaultContainer 'jnlp'
//       yaml """
// apiVersion: v1
// kind: Pod
// metadata:
// labels:
//   component: ci
// spec:
//   # Use service account that can deploy to all namespaces
//   serviceAccountName: jenkins-admin
//   containers:
//   - name: docker
//     image: docker:latest
//     command:
//     - cat
//     tty: true
//     volumeMounts:
//     - mountPath: /var/run/docker.sock
//       name: docker-sock
//   volumes:
//     - name: docker-sock
//       hostPath:
//         path: /var/run/docker.sock
// """
// }
//    }
//   stages {

//     stage('Push') {
//       steps {
//         git 'https://github.com/TanLocc/node-app.git'
//         container('docker') {
         
//           sh "docker build -t 0352730247/node-app:abc ."
//         }
//       }
//     }
//   }
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
            
            container('docker') {
              git 'https://github.com/TanLocc/node-app.git' 
              sh "docker build --network=host -t 0352730247/node-app:${dockerTag} ."
              kubeconfig(credentialsId: '3ae96b44-6cbf-4e96-b787-480e85d38642', serverUrl: 'https://2A0C42504940399165EA7BE05C44BE72.gr7.us-east-2.eks.amazonaws.com') {
                sh "kubectl get node"
              }     
              // withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
              //     sh "docker login -u 0352730247 -p ${dockerHubPwd}"
              // }
                  
              // sh "docker push 0352730247/node-app:${dockerTag}"
            }
        }
    }
}

// def getLatestCommitId(){
// 	def commitId = sh returnStdout: true, script: 'git rev-parse HEAD'
// 	return commitId
// }

