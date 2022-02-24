
def dockerTag = getLatestCommitId()

podTemplate {
    
    node(POD_LABEL) {
        stage('Run shell') {
            sh "docker build . -t 0352730247/node-app:$dockerTag "
        }
    }
}

def getLatestCommitId(){
	def commitId = sh returnStdout: true, script: 'git rev-parse HEAD'
	return commitId
}