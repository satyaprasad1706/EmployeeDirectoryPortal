pipeline {
    agent any

    triggers {
        // Automatically check GitHub for new commits every minute (ideal for local localhost setups)
        pollSCM('* * * * *')
    }

    tools {
        // Must match the name of the Maven installation in Jenkins Global Tool Configuration
        maven 'Maven 3'
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
                echo 'Deploying WAR package directly to Apache Tomcat webapps...'
                bat 'copy /Y target\\EmployeeDirectoryPortal.war "%CATALINA_HOME%\\webapps\\"'
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
