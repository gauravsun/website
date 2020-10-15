pipeline {
   agent none
   stages {
      stage('Git Source Code') {
         agent { label 'Build' }
         steps {
            git 'https://github.com/gauravsun/website.git'
         }
      }
      
      stage('Build Image') {
         agent { label 'Build' }
         steps {
            sh "sudo docker build -t gauravsun/customweb:BUILD_NUMBER ."
         }
      }
      
      stage('Push Image to Docker hub') {
         agent { label 'Build' }
         steps {
            sh "sudo docker push gauravsun/customweb:BUILD_NUMBER ."
         }
      }
      
       stage('Test website on Test Server') {
         agent { label 'Test' }
         steps {
            sh "java -jar App.jar"
         }
      }
      
      stage('Test website on Prod Server') {
         agent { label 'Prod' }
         steps {
            sh "java -jar App.jar"
         }
      }
      
      stage('Publish to Production') {
         agent { label 'Prod' }
         when {
          branch 'master'
          branch 'hotfix'
         }
         steps {
            git 'https://github.com/gauravsun/website.git'
            sh "sudo docker stop customwebcont 2> /dev/null || true"
            sh "sudo docker rm customwebcont 2> /dev/null || true"
            sh "sudo docker run --name customwebcont -itd -p 80:80 gauravsun/customweb:BUILD_NUMBER"
         }
      }
   }
}
