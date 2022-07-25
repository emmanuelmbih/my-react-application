pipeline {
    agent any
    tools {
        maven 'M2_HOME'
    }
    environment {
    registry = '043262182681.dkr.ecr.us-east-1.amazonaws.com/create-react-app'
    registryCredential = 'yahnah-dev'
    dockerimage = ''
  }
    stages {
        stage('Checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/emmanuelmbih/my-react-application.git'
            }
        }
        // stage('Code Build') {
        //     steps {
        //         echo 'Build jar file'
        //         sh 'mvn clean install'
        //     }
        // }
        // stage('Run Unit Test') {
        //     steps {
        //         echo 'Run unit test'
        //         sh 'mvn test'
            }
        }
        stage('Build Image') {
            steps {
                nodejs(nodeJSInstallationName: 'Node 6.x', configId: '<config-file-provider-id>') {
                    sh 'npm config ls'
                }
                script{
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                } 
            }
        }
        stage('Deploy image') {
            steps {
                script { 
                    docker.withRegistry("https://"+registry,"ecr:us-east-1:"+registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }  
    }
}
