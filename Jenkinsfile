pipeline {
    environment {
        ENV_NAME = 'dev'
        APP_BUILD_NUMBER = ''
    }

  agent any

  stages {
    stage('Build') {
      steps{
        script {
            if (env.ENV_NAME == 'dev') {
                echo $BUILD_NUMBER
            }
            else {
                echo $APP_BUILD_NUMBER
            }

        }
      }
    }
    stage('trigger-ppe-pipeline') {
      steps {
        build (
            job: 'ppe-pipeline-ppe',
            parameters: [
                [
                    $class: 'StringParameterValue',
                    name: 'APP_BUILD_NUMBER',
                    value: $BUILD_NUMBER,
                ]
            ]
        )
      }
    }
  }
}
