pipeline {
    agent any

    environment {
        APP_NAME = 'my-html-app'
        DOCKER_IMAGE = "${APP_NAME}:${env.BUILD_ID}"
        REGISTRY = 'docker.io/pratikp02'
        DEPLOY_SERVER = '65.0.107.37'  // Replace with your server IP or hostname
        SSH_USER = 'ec2-user'  // Replace with your SSH username
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
                sh 'sudo docker build -t ${REGISTRY}/${DOCKER_IMAGE} .'
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    echo 'Logging in to Docker Hub...'
                    sh '''
                    echo "$DOCKER_PASS" | sudo docker login -u "$DOCKER_USER" --password-stdin
                    sudo docker tag ${REGISTRY}/${DOCKER_IMAGE} ${REGISTRY}/${DOCKER_IMAGE}
                    sudo docker push ${REGISTRY}/${DOCKER_IMAGE}
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                sh '''
                ssh ${SSH_USER}@${DEPLOY_SERVER} "
                    sudo docker pull ${REGISTRY}/${DOCKER_IMAGE} &&
                    sudo docker stop ${APP_NAME} || true &&
                    sudo docker rm ${APP_NAME} || true &&
                    sudo docker run -d --name ${APP_NAME} -p 80:80 ${REGISTRY}/${DOCKER_IMAGE}
                "
                '''
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
