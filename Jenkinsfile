

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
  environment 
  { 

              AWS_ACCESS_KEY_ID     = credentials('devops-kubemaster-ssh')
      
  }
         
        steps {
        
                  sh 'echo "Service user is $AWS_ACCESS_KEY_ID"'
                sh 'echo "Service password is $AWS_ACCESS_KEY_ID_USR"'
                sh 'echo "Service password is $AWS_ACCESS_KEY_ID_PWD"'


  // script {
  //               sh 'printenv'
  //                echo 'Building Branch: ' + $AWS_ACCESS_KEY_ID
  //                   // def remote = [name: 'test', host: '192.168.56.20', user: ${AWS_ACCESS_KEY_ID_USR}, identityFile: ${AWS_ACCESS_KEY_ID_PSW}, allowAnyHosts: true]
  //                    //sshCommand remote: remote, command: "for i in {1..5}; do echo -n \"Loop \$i \"; date ; sleep 1; done"
  //                }
      

  
                    // Variables for input

                    
      
           }
        }
    
      
  }
}
