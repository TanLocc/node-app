pipeline{
    agent any
    environment{
        dockerTag = getLatestCommitId()
        devIp = '172.31.86.231'
    }
    stages {
        stage('Docker - Build & Push'){
            steps{
                sh "docker build . -t 0352730247/node-app:${dockerTag} "
                
                withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                    sh "docker login -u 0352730247 -p ${dockerHubPwd}"
                }
                
                sh "docker push 0352730247/node-app:${dockerTag}"
            }
        }
        
        stage('Dev Deploy'){
            steps {
                sh "chmod +x changeTag.sh"
                sh "./changeTag.sh ${dockerTag}"
                sshagent(['afdad1af-5999-4b9d-a40e-c467dc1152d9']) {
                     script{
					    sh returnStatus: true, script: "ssh ubuntu@${devIp} docker rm -f nodeapp"
						def runCmd = "docker run -d -p 8080:8080 --name=nodeapp 0352730247/nodeapp:${dockerTag}"
						sh "ssh -o StrictHostKeyChecking=no ubuntu@${devIp} ${runCmd}"
					}
                    // sh "scp -o StrictHostKeyChecking=no services.yml node-app-pod.yml ubuntu@${devIp}:/home/ubuntu/"
                    // script{
                    //     try {
                    //         sh "ssh ubuntu@${devIp} kubectl apply -f ."
                    //     } catch {
                    //         sh "ssh ubuntu@${devIp} kubectl create -f ."
                    //     }
                    // }
                }
            }
        }
    }
}

def getLatestCommitId(){
	def commitId = sh returnStdout: true, script: 'git rev-parse HEAD'
	return commitId
}