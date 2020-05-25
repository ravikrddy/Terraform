pipeline {
  environment {
    ENV_NAME = "${ENV_NAME}"
    APP_BUILD_NUMBER = "${APP_BUILD_NUMBER}"
  }

  agent any

  switch("${env.ENV_NAME}") {
    case "ppe":
      verify()
      echo "Run ppe pipeline"
      echo "echo $APP_BUILD_NUMBER"
      break;
    case "prod":
      verify()
      echo "Run prod pipeline"
      echo "echo $APP_BUILD_NUMBER"
      break;
    default:
      echo "Run dev pipeline"
      echo "echo $BUILD_NUMBER"
      build()
      break;
  }

}

def verify() {

    stage('Verify') {

        def userInput = input(
            id: 'userInput', message: 'This is ${ENV_NAME}!', parameters: [
            [$class: 'BooleanParameterDefinition', defaultValue: false, description: '', name: 'Please confirm you sure to proceed']
        ])

        if(!userInput) {
            error "Build wasn't confirmed"
        }
    }
}

def build() {

    stage('Build') {

        def triggerBuild = build(
            job: 'ppe-pipeline-plm', parameters: [
            [$class: 'StringParameterValue', name: 'APP_BUILD_NUMBER', value: "${APP_BUILD_NUMBER}"]
        ])

        if(!triggerBuild) {
            error "Build wasn't successful"
        }
    }
}
