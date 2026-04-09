pipeline {
    agent any

    triggers {
        cron('0 0 * * *')
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
                bat 'C:\\Users\\anike\\AppData\\Local\\Programs\\Python\\Python311\\Scripts\\pip.exe install -r requirements.txt'
            }
        }

        stage('Run PyTest Suite') {
            steps {
                echo 'Running PyTest tests...'
                bat 'C:\\Users\\anike\\AppData\\Local\\Programs\\Python\\Python311\\Scripts\\pytest.exe test/pytest/test_calculator.py -v --html=results/pytest/report.html --self-contained-html'
            }
        }

        stage('Run Robot Framework Suite') {
            steps {
                echo 'Running Robot Framework tests...'
                bat 'C:\\Users\\anike\\AppData\\Local\\Programs\\Python\\Python311\\Scripts\\robot.exe --outputdir results/robot test/robot/calculator.robot'
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
            mail to: 'aniket.naik.anil@gmail.com',
                 subject: "Jenkins Pipeline SUCCESS - ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: "All tests passed. Build URL: ${env.BUILD_URL}"
        }
        failure {
            echo 'Some tests failed!'
            mail to: 'aniket.naik.anil@gmail.com',
                 subject: "Jenkins Pipeline FAILED - ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: "Pipeline failed. Check console: ${env.BUILD_URL}console"
        }
        always {
            echo 'Pipeline completed.'
        }
    }
}