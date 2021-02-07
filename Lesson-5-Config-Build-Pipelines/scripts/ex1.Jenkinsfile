pipeline {
	agent any
    stages {
        stage('First Stage') {
                steps {
                    echo 'Hello World'
                }
        }
        stage('Second Stage') {
                steps {
                    echo 'Hello Again'
                    echo 'A third time Hello'
                }
        }
	}
}

OR

# CRON Enabled Job
pipeline {
	agent any
    triggers {
        cron('* * * * *')
    }
    stages {
        stage('First Stage') {
                agent {label}
                steps {
                    echo 'Hello World'
                }
        }
        stage('Second Stage') {
                agent {label}
                steps {
                    echo 'Hello Again'
                    echo 'A third time Hello'
                }
        }
	}
}

OR

# Stage Controlled job
pipeline {
    agent any
    stages {
        stage('Example Build') {
            agent any
            steps {
                echo 'Hello World'
            }
        }
        stage('Example Test') {
            agent any
            steps {
            	echo 'Hello Again'
            	echo 'A third time Hello'
            }
        }
    }
}
