pipeline {
	agent any
	tools {
    	maven 'MavenHome'
	}
	stages {
    	stage("Checkout") {
        	steps {
        	    git branch: 'main',
                    credentialsId: 'wjfrelo',
                    url: 'git@github.com:wjfrelo/SLMavenTest.git'
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

       	stage('deploy') {
            steps {
                echo "Im DONE"
            }
        }
    }
}