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
                sh "buildNumber=$(curl localhost:8080/job/dev-pipeline-plm/lastSuccessfulBuild/buildNumber) ; \
                echo '$buildNumber'"
            }
            else if (env.ENV_NAME == 'prod') {
                sh "buildNumber=$(curl localhost:8080/job/ppe-pipeline-plm/lastSuccessfulBuild/buildNumber) ; \
                echo '$buildNumber'"
            }
            else {
                sh "echo ${BUILD_NUMBER}"
            }

        }
      }
    }
  }
}
