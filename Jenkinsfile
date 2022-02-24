
podTemplate {
    def dockerTag = getLatestCommitId()
    node(POD_LABEL) {
        stage('Run shell') {
            sh "docker build . -t 0352730247/node-app:${dockerTag} "
                
            withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                sh "docker login -u 0352730247 -p ${dockerHubPwd}"
            }
                
            sh "docker push 0352730247/node-app:${dockerTag}"
        }
    }
}

def getLatestCommitId(){
	def commitId = sh returnStdout: true, script: 'git rev-parse HEAD'
	return commitId
}