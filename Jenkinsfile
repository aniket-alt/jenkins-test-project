pipeline {
    agent any

    triggers {
        // Cron trigger - runs every day at midnight
        cron('0 0 * * *')
        // Code push trigger - runs when code is pushed to GitHub
        githubPush()
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from GitHub...'
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing dependencies...'
                bat 'pip install -r requirements.txt'
            }
        }

        stage('Run PyTest Suite') {
            steps {
                echo 'Running PyTest tests...'
                bat 'pytest tests/pytest/test_calculator.py -v --html=results/pytest/report.html --self-contained-html'
            }
        }

        stage('Run Robot Framework Suite') {
            steps {
                echo 'Running Robot Framework tests...'
                bat 'robot --outputdir results/robot tests/robot/calculator.robot'
            }
        }

        stage('Archive Reports') {
            steps {
                echo 'Archiving test reports...'
                archiveArtifacts artifacts: 'results/**/*.html', allowEmptyArchive: true
            }
        }
    }

    post {
        success {
            echo 'All tests passed successfully!'
            mail(
                to: 'aniket.naik.anil@gmail.com',
                subject: "✅ Jenkins Pipeline SUCCESS - ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
                    Hi Aniket,

                    Good news! All tests passed successfully.

                    Pipeline Details:
                    - Job: ${env.JOB_NAME}
                    - Build Number: ${env.BUILD_NUMBER}
                    - Status: SUCCESS
                    - Build URL: ${env.BUILD_URL}

                    Check the archived reports for details:
                    ${env.BUILD_URL}artifact/results/

                    Regards,
                    Jenkins
                """
            )
        }
        failure {
            echo 'Some tests failed! Sending failure notification...'
            mail(
                to: 'aniket.naik.anil@gmail.com',
                subject: "❌ Jenkins Pipeline FAILED - ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
                    Hi Aniket,

                    The pipeline has failed. Immediate attention required!

                    Pipeline Details:
                    - Job: ${env.JOB_NAME}
                    - Build Number: ${env.BUILD_NUMBER}
                    - Status: FAILED
                    - Build URL: ${env.BUILD_URL}

                    Please check the console output and archived reports:
                    ${env.BUILD_URL}console
                    ${env.BUILD_URL}artifact/results/

                    Regards,
                    Jenkins
                """
            )
        }
        always {
            echo 'Pipel