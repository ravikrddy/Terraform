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
  }
  post {
    success {
      if ($ENV_NAME == 'dev') {
        steps {
            def job = build job: 'ppe-pipeline-plm', parameters: [[$class: 'StringParameterValue', name: 'APP_BUILD_NUMBER', value: $BUILD_NUMBER]]
        }
      }
      if ($ENV_NAME == 'ppe') {
        steps {
            def job = build job: 'prod-pipeline-plm', parameters: [[$class: 'StringParameterValue', name: 'APP_BUILD_NUMBER', value: $APP_BUILD_NUMBER]]
        }
      }
    }
  }
}
