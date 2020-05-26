def devBuildNumber = Jenkins.instance.getItem('dev-pipeline-plm').lastSuccessfulBuild.number
def ppeBuildNumber = Jenkins.instance.getItem('ppe-pipeline-plm').lastSuccessfulBuild.number
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
                sh "echo $devBuildNumber"
            }
            else if (env.ENV_NAME == 'prod') {
                sh "echo $ppeBuildNumber"
            }
            else {
                sh "echo $BUILD_NUMBER"
            }

        }
      }
    }
  }
}
