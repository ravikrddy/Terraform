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
                sh "devBuildNumber=curl localhost:8080/job/dev-pipeline-plm/lastSuccessfulBuild/buildNumber ; \
                echo $devBuildNumber"
            }
            else if (env.ENV_NAME == 'prod') {
                sh "ppeBuildNumber=curl localhost:8080/job/ppe-pipeline-plm/lastSuccessfulBuild/buildNumber ; \
                echo $ppeBuildNumber"
            }
            else {
                sh "echo $BUILD_NUMBER"
            }

        }
      }
    }
  }
}
