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
                sh "def buildNumber = Jenkins.instance.getItem('dev-pipeline-plm').lastSuccessfulBuild.number; \
                echo $buildNumber"
            }
            else if (env.ENV_NAME == 'prod') {
                sh "def buildNumber = Jenkins.instance.getItem('ppe-pipeline-plm').lastSuccessfulBuild.number; \
                echo $buildNumber"
            }
            else {
                sh "echo $BUILD_NUMBER"
            }

        }
      }
    }
  }
}
