pipeline {
    agent {
        label 'linux2'
    } 
    environment {
        AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')

	}
    stages {
        stage('Terraform Init: "$TERRAFORM_ACTION"') { 
            input {
                message "Should this '$TERRAFORM_ACTION' starts?"
            }
            steps {
                sh 'echo "Initializing Terraform"'
                sh '''
                    terraform init
                '''
            }
        }
        stage('Terraform Plan') { 
            steps {
                sh 'echo "Terraform Plan output"'
                sh '''
                    terraform plan
                '''
            }
        }
        stage('Terraform Action: $TERRAFORM_ACTION') { 
            input {
                message "Should this $TERRAFORM_ACTION starts?"
            }
            steps {
                sh 'echo "Terraform Action: $TERRAFORM_ACTION"'
                sh '''
                    terraform $TERRAFORM_ACTION -auto-approve
                    
                '''
            }
        }
        
        
    }
	post {
        always {
                   
            emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
            recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
            subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}"
        }
    }
}