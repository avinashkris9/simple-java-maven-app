

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
   stage('Manual Action') {
      agent any
            input {
                message "Should we continue?"
                ok "Yes, we should."
             
                parameters {
                     choice(name: 'Action', choices: ['Approve', 'Reject'], description: 'Pick action')
                }
            }
             steps {
                echo "Received input ${Action}"
            }
            }

    stage('Deploy to stage') {
        when {
               
                    expression { params.Action == 'Approve' }
        }
   
           agent any
  environment 
  { 

              AWS_ACCESS_KEY_ID     = credentials('devops-kubemaster-ssh')
      
  }
         
        steps {
        
                  sh 'echo "Service user is $AWS_ACCESS_KEY_ID"'
        
     

  script {

    def remote = [:]
remote.name = "kubemaster"
remote.host = "192.168.56.20"
remote.allowAnyHosts = true
     withCredentials([sshUserPrivateKey(credentialsId: 'devops-kubemaster-ssh', keyFileVariable: 'identity', passphraseVariable: '', usernameVariable: 'userName')]) {
        remote.user = userName
        remote.identityFile = identity
        stage("SSH Steps Rocks!") {
            writeFile file: 'abc.sh', text: 'ls'
            sshCommand remote: remote, command: 'for i in {1..5}; do echo -n \"Loop \$i \"; date ; sleep 1; done'
            sshPut remote: remote, from: 'abc.sh', into: '.'
            sshGet remote: remote, from: 'abc.sh', into: 'bac.sh', override: true
            sshScript remote: remote, script: 'abc.sh'
            sshRemove remote: remote, path: 'abc.sh'
        }
     }
      //    sh 'printenv'
       //           sh 'echo "Service password is $AWS_ACCESS_KEY_ID_USR"'
                          
         //   def remote = [name: 'test', host: '192.168.56.20', user: ${env.JOB_NAME}, //identityFile: ${env.JOB_NAME}, allowAnyHosts: true]
  //                echo 'Building Branch: ' + $AWS_ACCESS_KEY_ID
  //                   // 
  //                    //sshCommand remote: remote, command: "for i in {1..5}; do echo -n \"Loop \$i \"; date ; sleep 1; done"
               }
      

  
                    // Variables for input

                    
      
           }
        }
    
      
  }
}
