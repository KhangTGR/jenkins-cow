pipeline {
    agent any
    
    environment {
        DOCKERHUB_CREDENTIALS=credentials('dockerhub')
    }

    stages {
        stage('Preparation') {
            steps {
                echo 'BE PREPARED!'
                sh 'docker rm -f cowsay-container'
            }
        }
        
        stage('Build') {
            steps {
                git (
                    branch: 'main',
                    url: 'https://github.com/KhangTGR/cow-say.git'
                    )
                dir('code') {
                  sh 'docker build -t khangtgr/cowsay:v1.1 .'
                }
                sh 'ls'
            }
        }

        stage('Test') {
            steps {
                sh 'docker run -d --rm -p 8080:8080 --name cowsay-container khangtgr/cowsay:v1.1'
                sh 'sleep 10'
                sh 'docker ps -a'
                sh 'curl docker:8080'
            }
        }
        
        stage('Publish') {
            steps {
                sh 'docker rm -f cowsay-container'
                sh 'docker images'
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push khangtgr/cowsay:v1.1'
            }
        }

        stage('Deploy') {
            when {
              expression {
                currentBuild.result == null || currentBuild.result == 'SUCCESS' 
              }
            }
            
            steps {
                sh 'docker rmi khangtgr/cowsay:v1.1'
                sh 'docker pull khangtgr/cowsay:v1.1'
                sh 'docker run -d --rm -p 8080:8080 --name cowsay-container khangtgr/cowsay:v1.1'
            }
        }
    }
    
    post {
		always {
		    sh 'docker rmi -f khangtgr/cowsay:v1.1'
			sh 'docker logout'
			mail to: "khangtgr@gmail.com",
            subject: "Report",
            body: "Build ${currentBuild.currentResult}"
		}
	}
	
}
