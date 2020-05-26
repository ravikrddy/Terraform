pipeline {
  environment {
    ENV_NAME = ${ENV_NAME}
    APP_BUILD_NUMBER = ${APP_BUILD_NUMBER}
  }

  agent any

  stages {
    stage('Build') {
      steps{
        script {
            if ($ENV_NAME == 'dev') {
                sh "echo $BUILD_NUMBER"
            }
            else {
                sh "echo $APP_BUILD_NUMBER"
            }

        }
      }
    }
  }
}
