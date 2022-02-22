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
               sshagent(['loclpt-keypair-virginia']) {
                     script{
					    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.86.231 docker rm -f nodeapp'
						def runCmd = "docker run -d -p 8080:8080 --name=nodeapp 0352730247/nodeapp:${dockerTag}"
						sh "ssh -o StrictHostKeyChecking=no ubuntu@${devIp} ${runCmd}"
					
                        sh 'ssh -o StrictHostKeyChecking=no tanloc@192.168.1.6 rm -rf /home/tanloc/jenkins'
                        sh 'ssh -o StrictHostKeyChecking=no tanloc@192.168.1.6 mkdir /home/tanloc/jenkins'
                        sh 'scp -o StrictHostKeyChecking=no index.html tanloc@192.168.1.6:/home/tanloc/jenkins'
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