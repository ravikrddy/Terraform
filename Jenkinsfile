pipeline {
  environment {
    ENV_NAME = "${ENV_NAME}"
  }

  agent any

  stages {
    stage('Build') {
      steps{
        script {
            if (env.ENV_NAME == 'ppe') {
                DEV_BUILD_NUMBER=$(curl localhost:8080/job/dev-pipeline-plm/lastSuccessfulBuild/buildNumber)
                echo $DEV_BUILD_NUMBER
            }
            else if (env.ENV_NAME == 'prod') {
                PPE_BUILD_NUMBER=$(curl localhost:8080/job/ppe-pipeline-plm/lastSuccessfulBuild/buildNumber)
                echo $PPE_BUILD_NUMBER
            }
            else {
                sh "echo ${BUILD_NUMBER}"
            }

        }
      }
    }
  }
}
