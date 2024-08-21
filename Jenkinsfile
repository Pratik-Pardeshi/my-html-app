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
                // Ensure you have proper credentials and Git configuration
                checkout scm
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    echo 'Building Docker image...'
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh '''
                        # Log in to Docker Hub
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

                        # Build the Docker image using the Dockerfile from GitHub
                        docker build -t ${REGISTRY}/${DOCKER_IMAGE} .
                        '''
                    }
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    echo 'Pushing Docker image to registry...'
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh '''
                        # Log in to Docker Hub
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

                        # Push the Docker image to the registry
                        docker push ${REGISTRY}/${DOCKER_IMAGE}
                        '''
                    }
                }
            }
        }

        stage('Cleanup') {
            steps {
                script {
                    echo 'Cleaning up Docker images...'
                    sh '''
                    # Remove unused Docker images
                    docker image prune -f
                    '''
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
