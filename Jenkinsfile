pipeline {
   agent none
   stages {
      stage('Run container on Prod Server') {
         agent { label 'Prod' }
         steps {
            sh "kubectl apply -f deploy.yml"
            sh "kubectl apply -f servicedeploy.yml"
         }
      }
      
   }
}
