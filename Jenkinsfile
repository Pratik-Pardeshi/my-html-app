pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out code from GitHub...'
                // Check out code from GitHub
                checkout scm
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    echo 'Building Docker image...'
                    // Log in to Docker Hub
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        # Build Docker image
                        docker build -t docker.io/pratikp02/my-html-app:${BUILD_ID} .
                        '''
                    }
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    echo 'Pushing Docker image to Docker Hub...'
                    // Push Docker image to Docker Hub
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push docker.io/pratikp02/my-html-app:${BUILD_ID}
                        '''
                    }
                }
            }
        }

        stage('Deploy Application') {
            steps {
                script {
                    echo 'Deploying application...'
                    // Deploy the Docker container
                    sh '''
                    # Stop and remove the old container if it exists
                    docker stop my-html-app || true
                    docker rm my-html-app || true

                    # Run the new container
                    docker run -d --name my-html-app -p 80:80 docker.io/pratikp02/my-html-app:${BUILD_ID}
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
