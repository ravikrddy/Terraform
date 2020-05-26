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
                sh "wget -qO- localhost:8080/job/dev-pipeline-plm/lastSuccessfulBuild/buildNumber"
            }
            else if (env.ENV_NAME == 'prod') {
                sh "wget -qO- localhost:8080/job/ppe-pipeline-plm/lastSuccessfulBuild/buildNumber"
            }
            else {
                sh "echo $BUILD_NUMBER"
            }

        }
      }
    }
  }
}
