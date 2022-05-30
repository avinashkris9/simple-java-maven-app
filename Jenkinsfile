

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

              AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id-mumbai')

         }
        steps {
        

             def remote = [:]
    remote.name = 'test'
    remote.host = '13.233.134.62'
    remote.user = 'ubuntu'
 remote.identityFile = ${AWS_ACCESS_KEY_ID}
    remote.allowAnyHosts = true

      
     script {
                  
               
                writeFile file: 'abc.sh', text: 'ls'
            sshCommand remote: remote, command: 'for i in {1..5}; do echo -n \"Loop \$i \"; date ; sleep 1; done'
              sshPut remote: remote, from: 'abc.sh', into: '.'
                   
           }
  
                    // Variables for input

                    
      
           }
        }
    
      
  }
}
