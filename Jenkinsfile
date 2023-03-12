pipeline {
  
  agent any 
  environment {
    DOCKER_REGISTRY = "sheguey888"
    DOCKER_IMAGE_NAME = "sheguey888/mean-crud-front"
    SONAR_PROJECT_KEY = "squ_a7f8981ea4ef296d37ed4a0c21c01a7c402dba35"
    SONAR_PROJECT_NAME = "Mean Crud Front"
    DOCKERHUB_CREDENTIALS = credentials('a2f773e9-3ac5-420d-9bc3-f13f343df610')
  }

  stages {
    
  
    
    stage('Code Quality Analysis') {
      steps {
        withSonarQubeEnv('SonarQube') {
          sh 'npm run sonarqube -Dsonar.projectKey=$SONAR_PROJECT_KEY -Dsonar.projectName="$SONAR_PROJECT_NAME" -Dsonar.host.url=http://localhost:9000'
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
  
  post {
    always {
      cleanWs()
    }
  }
}
