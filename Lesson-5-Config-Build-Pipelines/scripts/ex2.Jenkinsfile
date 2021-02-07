pipeline {
	agent any
	tools {
    	maven '<add your configured mvn home>'
	}
	stages {
    	stage("Checkout") {
        	steps {
        	    git branch: 'main',
                    credentialsId: '<add your key name>',
                    url: '<add your ssh git address here>'
        	}
    	}
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

