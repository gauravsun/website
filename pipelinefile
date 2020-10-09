pipeline {
   agent none
   stages {
      stage('Git Source Code') {
         agent { label 'test' }
         steps {
            git 'https://github.com/gauravsun/website.git'
         }
      }
      stage('Build Image') {
         agent { label 'test' }
         steps {
            sh "sudo docker build -t webapp /home/ec2-user/workspace/test"
         }
      }
      stage('Run Container') {
         agent { label 'test' }
         steps {
            sh "sudo docker run --name webappcont -itd -p 80:80 webapp"
         }
      }
      stage('Test Website') {
         agent { label 'test' }
         steps {
            sh "java -jar App.jar"
         }
      }
      stage('Delete Test Image and Container') {
         agent { label 'test' }
         steps {
            sh "sudo docker stop webappcont 2> /dev/null || true"
            sh "sudo docker rm webappcont 2> /dev/null || true"
            sh "sudo docker rmi webapp 2> /dev/null || true"
            sh "sudo docker stop webappcont 2> /dev/null || true"
         }
      }
      stage('Publish to production') {
         agent { label 'prod' }
         when {
          branch 'master'
         }
         steps {
            git 'https://github.com/gauravsun/website.git'
            sh "sudo docker stop webappcont 2> /dev/null || true"
            sh "sudo docker rm webappcont 2> /dev/null || true"
            sh "sudo docker rmi webapp 2> /dev/null || true"
            sh "sudo docker stop webappcont 2> /dev/null || true"
            sh "sudo docker build -t webapp /home/ec2-user/workspace/test"
            sh "sudo docker run --name webappcont -itd -p 80:80 webapp"
         }
      }
   }
}
