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
                sh "echo Jenkins.instance.getItem('dev-pipeline-plm').lastSuccessfulBuild.number"
            }
            else if (env.ENV_NAME == 'prod') {
                sh "echo Jenkins.instance.getItem('ppe-pipeline-plm').lastSuccessfulBuild.number"
            }
            else {
                sh "echo $BUILD_NUMBER"
            }

        }
      }
    }
  }
}
