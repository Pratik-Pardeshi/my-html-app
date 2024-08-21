pipeline {
    agent any

    environment {
        APP_NAME = 'my-html-app'
        DOCKER_IMAGE = "${APP_NAME}:${env.BUILD_ID}"
        REGISTRY = 'docker.io/pratikp02'
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out code from GitHub...'
                checkout scm
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Building Docker image...'
                withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo "$DOCKER_PASS" | sudo docker login -u "$DOCKER_USER" --password-stdin
                    sudo docker build -t ${REGISTRY}/${DOCKER_IMAGE} .
                    '''
                }
            }
        }

        stage('Docker Push') {
            steps {
                echo 'Pushing Docker image to registry...'
                withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo "$DOCKER_PASS" | sudo docker login -u "$DOCKER_USER" --password-stdin
                    sudo docker push ${REGISTRY}/${DOCKER_IMAGE}
                    '''
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            sh 'sudo docker image prune -f'
        }
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
