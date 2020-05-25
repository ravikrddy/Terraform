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
                sh "echo $APP_BUILD_NUMBER; echo $ENV_NAME"
            }

        }
      }
    }
    stage('ppe deploy approval'){
      input "Deploy to ppe?"
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
    stage('prod deploy approval'){
      input "Deploy to prod?"
    }
    stage('trigger-prod-pipeline') {
      when {
        environment name: 'ENV_NAME', value: 'ppe'
      }
      steps {
        build (
            job: 'prod-pipeline-plm',
            parameters: [
                [
                    $class: 'StringParameterValue',
                    name: 'APP_BUILD_NUMBER',
                    value: "${APP_BUILD_NUMBER}",
                ]
            ]
        )
      }
    }
  }
}
