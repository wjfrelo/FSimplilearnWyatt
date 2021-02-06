pipeline {
	agent any
	tools {
    	maven '<add your configured mvn home>'
	}
	stages {
    	stage('Build') {
        	steps {
        	    sh "mvn compile"
        	}
    	}

    	stage("Unit test") {
        	steps {
            	sh "mvn test"
       	}
    }
}

