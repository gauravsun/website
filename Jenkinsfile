pipeline {
   agent none
   stages {
      stage('Git Source Code') {
         agent { label 'Test' }
         steps {
            git 'https://github.com/gauravsun/website.git'
         }
      }
      stage('Build Image') {
         agent { label 'Test' }
         steps {
            sh "sudo docker build -t gauravwebapp ."
         }
      }
     
      stage('Delete Test Image') {
         agent { label 'Test' }
         steps {
            sh "sudo docker rmi gauravwebapp 2> /dev/null || true"
         }
      }
      
       stage('Test Website') {
         agent { label 'Prod' }
         steps {
            sh "java -jar App.jar"
         }
      }
      stage('Publish to production') {
         agent { label 'Prod' }
         when {
          branch 'master'
          branch 'hotfix'
         }
         steps {
            git 'https://github.com/gauravsun/website.git'
            sh "sudo docker stop gauravwebappcont 2> /dev/null || true"
            sh "sudo docker rm gauravwebappcont 2> /dev/null || true"
            sh "sudo docker rmi gauravwebapp 2> /dev/null || true"
            sh "sudo docker stop gauravwebappcont 2> /dev/null || true"
            sh "sudo docker build -t gauravwebapp ."
            sh "sudo docker run --name gauravwebappcont -itd -p 80:80 gauravwebapp"
         }
      }
   }
}
