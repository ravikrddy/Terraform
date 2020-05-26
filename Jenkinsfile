pipeline {
  environment {
    ENV_NAME = "${ENV_NAME}"
    DEV_BUILD_NUMBER = "\$(curl localhost:8080/job/dev-pipeline-plm/lastSuccessfulBuild/buildNumber)"
    PPE_BUILD_NUMBER = "\$(curl localhost:8080/job/dev-pipeline-plm/lastSuccessfulBuild/buildNumber)"
  }

  agent any

  stages {
    stage('Build') {
      steps{
        script {
            if (env.ENV_NAME == 'ppe') {
                sh "echo ${DEV_BUILD_NUMBER}"
            }
            else if (env.ENV_NAME == 'prod') {
                sh "echo ${PPE_BUILD_NUMBER}"
            }
            else {
                sh "echo $BUILD_NUMBER"
            }

        }
      }
    }
  }
}
