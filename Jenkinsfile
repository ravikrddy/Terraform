pipeline {
  environment {
    ENV_NAME = "${ENV_NAME}"
    APP_BUILD_NUMBER = "${APP_BUILD_NUMBER}"
  }

  agent any

  stages {
    stage('Build') {
      steps{
        script {
            if (env.ENV_NAME == 'dev') {
                sh "echo $BUILD_NUMBER"
            }
            else {
                sh "echo $APP_BUILD_NUMBER"
            }

        }
      }
    }
    stage('trigger-ppe-pipeline') {
      when {
        environment name: 'ENV_NAME', value: 'dev'
      }
      steps {
        build (
            job: 'ppe-pipeline-plm',
            parameters: [
                [
                    $class: 'StringParameterValue',
                    name: 'APP_BUILD_NUMBER',
                    value: "${BUILD_NUMBER}",
                ]
            ]
        )
      }
    }
  }
}
