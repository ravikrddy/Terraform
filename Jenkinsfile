pipeline {
    environment {
        ENV_NAME = credentials('ENV_NAME')
        APP_BUILD_NUMBER = ''
    }

  agent any

  stages {
    stage('Build') {
      steps{
        script {
            if ($ENV_NAME == 'dev') {
                echo $BUILD_NUMBER
            }
            else {
                echo $APP_BUILD_NUMBER
            }

        }
      }
    }
    stage('trigger-ppe-pipeline') {
      def job = build job: 'ppe-pipeline-plm', parameters: [[$class: 'StringParameterValue', name: 'APP_BUILD_NUMBER', value: $BUILD_NUMBER]]
    }
  }
}
