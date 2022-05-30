

pipeline {
   agent any    

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
        
          script {
       
           docker.withRegistry('', 'dockerhub') {
          def customImage = docker.build("indestructiblekris9/my-app")
            customImage.push("${env.BUILD_NUMBER}")
            customImage.push("latest")
       }
        }
        }
    
      }


    stage('Deploy to stage') {
   
           agent any

         environment { 
                AN_ACCESS_KEY = credentials('aws-pkey-mumbai') 
         }
        steps {
           script {

             def aws_ip="13.233.134.62"
             def remote = [:]
    remote.name = 'test'
    remote.host = '13.233.134.62'
    remote.user = 'ubuntu'
    remote.password = ${AN_ACCESS_KEY}
    remote.allowAnyHosts = true
    stage('Remote SSH') {
      
      sshCommand remote: remote, command: "ls -lrt"
         sshCommand remote: remote, command: "touch iamhere"
      sshCommand remote: remote, command: "for i in {1..5}; do echo -n \"Loop \$i \"; date ; sleep 1; done"
    }
           }
  
                    // Variables for input

                    
              
           }
        }
    
      
  }
}
