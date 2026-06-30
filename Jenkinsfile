pipeline {
    agent any

    tools {
        // Must match the name of the Maven installation in Jenkins Global Tool Configuration
        maven 'Maven_3.8'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout current repository files
                checkout scm
            }
        }

        stage('Compile') {
            steps {
                echo 'Compiling sources...'
                bat 'mvn clean compile'
            }
        }

        stage('Unit Tests') {
            steps {
                echo 'Running unit tests...'
                bat 'mvn test'
            }
            post {
                always {
                    // Archive JUnit test reports
                    junit '**/target/surefire-reports/*.xml'
                }
            }
        }

        stage('Package') {
            steps {
                echo 'Generating WAR file...'
                bat 'mvn package -DskipTests'
            }
            post {
                success {
                    // Archive generated WAR as build artifact
                    archiveArtifacts artifacts: 'target/*.war', followSymlinks: false
                }
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                echo 'Deploying WAR package to Apache Tomcat server...'
                // Invokes the tomcat7:redeploy maven target to deploy on the configured Tomcat instance
                bat 'mvn tomcat7:redeploy'
            }
        }
    }

    post {
        success {
            echo '========================================='
            echo 'CI/CD Pipeline Successful!'
            echo 'Application deployed to Tomcat.'
            echo '========================================='
        }
        failure {
            echo '========================================='
            echo 'CI/CD Pipeline Failed!'
            echo 'Please review console output log.'
            echo '========================================='
        }
    }
}
