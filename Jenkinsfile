pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out code...'
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing dependencies...'
                // If you have dependencies, install them here, e.g., npm install
            }
        }

        stage('Build') {
            steps {
                echo 'Building the application...'
                // Include build steps, if necessary
            }
        }

        stage('Run Tests') {
            steps {
                echo 'Running tests...'
                // Run your tests here
                sh 'node tests/test.js'
            }
        }

        stage('Linting') {
            steps {
                echo 'Running linters...'
                // Run your linters here, e.g., ESLint for JS, CSSLint for CSS
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Building Docker image...'
                script {
                    dockerImage = docker.build("my-html-app:${env.BUILD_ID}")
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                script {
                    dockerImage.push()
                    // You can add deployment commands here, e.g., push to a registry or deploy to a server
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            // Clean up steps if necessary
        }
    }
}
