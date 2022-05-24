

pipeline {
   agent any    
  environment {
        DockerHub_Credentials = credentials("dockerhub")
    }
  options {
    skipStagesAfterUnstable()
  }
  stages {
    stage('maven-build-process') {

      agent {
        docker {
          image 'maven:3.8.1-adoptopenjdk-11'
          args '-v /root/.m2:/root/.m2'
        }
      }
        stages {
      stage('Build') {
        steps {
          sh 'mvn -B -DskipTests clean package'
        }
      }
      stage('Test') {
        steps {
          sh 'mvn test'
        }
        post {
          always {
            junit 'target/surefire-reports/*.xml'
          }
        }
      }

    }
    }
   stage('Build Docker') {
     def customImage
      agent any
        steps {
          script {
            customImage = docker.build(" my-app:1.0")
           docker.withRegistry('https://registry.hub.docker.com', 'dockerHub') {
            customImage.push("${env.BUILD_NUMBER}")
            customImage.push("latest")
       }
        }
        }
    
      }
  }
}
