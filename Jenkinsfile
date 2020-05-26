pipeline {
  environment {
    ENV_NAME = "${ENV_NAME}"
    APP_NAME = "${APP_NAME}"
    PPE_BUILD_NUMBER = "\$(curl localhost:8080/job/dev-pipeline-$APP_NAME/lastSuccessfulBuild/buildNumber)"
    PROD_BUILD_NUMBER = "\$(curl localhost:8080/job/ppe-pipeline-$APP_NAME/lastSuccessfulBuild/buildNumber)"
  }

  agent any

  stages {
    stage('Build') {
      steps{
        script {
            if (env.ENV_NAME == 'ppe') {
                sh "echo ${PPE_BUILD_NUMBER}"
            }
            else if (env.ENV_NAME == 'prod') {
                sh "echo ${PROD_BUILD_NUMBER}"
            }
            else {
                sh "echo ${BUILD_NUMBER}"
            }

        }
      }
    }
  }
}
