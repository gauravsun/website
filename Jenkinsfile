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
            sh "sudo docker build -t gauravsun/customweb:$BUILD_NUMBER ."
         }
      }
      
      stage('Push Image to Docker hub') {
         agent { label 'Build' }
         steps {
            sh "sudo docker push gauravsun/customweb:$BUILD_NUMBER ."
         }
      }
      
       stage('Test website on Test Server') {
         agent { label 'Test' }
         steps {
            sh "java -jar App.jar"
         }
      }
   }
}
