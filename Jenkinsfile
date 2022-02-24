podTemplate {
    environment{
        dockerTag = getLatestCommitId()
        devIp = '3.84.50.84'
    }
    node(POD_LABEL) {
        stage('Run shell') {
            sh 'echo hello world'
        }
    }
}