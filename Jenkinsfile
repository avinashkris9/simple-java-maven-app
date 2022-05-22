pipeline {
    agent 
    {
        any
    }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub')
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
      stage('Deliver') {
        steps {
          sh './jenkins/scripts/deliver.sh'
        }
      }
    }
  }
}