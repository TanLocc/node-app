
def dockerTag = "${getLatestCommitId().toString()}"
def getLatestCommitId(){
	def commitId = sh returnStdout: true, script: 'git rev-parse HEAD'
	return commitId
}
podTemplate (containers: [
    containerTemplate(
        name: 'jnlp', 
        image: 'jenkins/inbound-agent:latest'
        )
  ]){
    
    node(POD_LABEL) {
        stage('Run shell') {
            container('jnlp') {
                            sh "docker build . -t 0352730247/node-app:${dockerTag} "
                
            withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                sh "docker login -u 0352730247 -p ${dockerHubPwd}"
            }
                
            sh "docker push 0352730247/node-app:${dockerTag}"
            }
        }
    }
}

