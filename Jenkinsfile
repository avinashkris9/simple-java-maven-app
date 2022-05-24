def jarFileName=""
pipeline {
   agent any    
  environment {
        ENV_NAME = "${NAME}-${VERSION}"
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
      agent any
        steps {
          sh 'docker build -t my-app:1.0 .'

         
        }
    
      }
  }
}
