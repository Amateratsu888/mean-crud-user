pipeline {
  
  agent any 
  environment {
    DOCKER_REGISTRY = "sheguey888"
    DOCKER_IMAGE_NAME = "sheguey888/mean-crud-front"
    SONAR_PROJECT_KEY = "squ_70c3b8b66bb5b34f38403879ae2e8617c90e7330"
    SONAR_PROJECT_NAME = "Mean Crud Front"
    DOCKERHUB_CREDENTIALS = credentials('a2f773e9-3ac5-420d-9bc3-f13f343df610')
  }

  stages {
    
   stage ('Install dependency') {
     steps {
          sh 'export PATH="$PATH:/usr/local/bin"'
          sh 'npm install'
     }
     
        
    } 
    
    stage('Code Quality Analysis') {
      steps {
        withSonarQubeEnv('sonarServer') {
          sh 'npm run sonar '
        }
      }
    }
    
    stage('Build Docker Image') {
      steps {
        script {
          docker.build("$DOCKER_IMAGE_NAME:latest")
        }
      }
    }
    
    stage('Push Docker Image') {
      steps {
        script {
          docker.withRegistry("//https://hub.docker.com/","$DOCKERHUB_CREDENTIALS") {
            dockerImage.push()
          }
        }
      }
    }
  }
  

}
