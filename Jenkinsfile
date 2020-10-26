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
            sh "cat dockerpass.txt | sudo docker login --username gauravsun --password-stdin"
            sh "sudo docker push gauravsun/customweb:$BUILD_NUMBER"
         }
      }
      
       stage('Run container on Test Server') {
         agent { label 'Test' }
         steps {
            sh "sudo docker run --name customwebcont -itd -p 80:80 gauravsun/customweb:$BUILD_NUMBER"
         }
      }
      
       stage('Test website on Test Server') {
         agent { label 'Test' }
         steps {
            sh "java -jar App.jar"
            sh "sudo docker stop customwebcont 2> /dev/null || true"
            sh "sudo docker rm customwebcont 2> /dev/null || true"
         }
      }
      
      stage('Run container on Prod Server') {
         agent { label 'Prod' }
         steps {
            sh "sudo docker stop webappcont 2> /dev/null || true"
            sh "sudo docker rm webappcont 2> /dev/null || true"
            sh "kubectl apply -f deploy.yml"
            sh "kubectl apply -f servicedeploy.yml"
         }
      }
      
   }
}
