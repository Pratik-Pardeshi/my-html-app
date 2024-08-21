pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out code...'
                checkout scm
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Building Docker image...'
                sh 'sudo docker build -t my-html-app:${env.BUILD_ID} .'
            }
        }

        // Other stages remain the same
    }
}
