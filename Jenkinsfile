pipeline {
  agent any
  parameters {
      choice(name: 'tf_action', choices: ['apply', 'destroy', ], description: 'Please select terraform action to perform.')
  }
  stages {
      stage ("Test Stage") {
            when { branch "master" }
                  steps {  
                        echo "Running Terrafrom from ${env.BRANCH_NAME}"
                  }
      }
      stage ("Terraform Init ") {
            steps {
                  withAWS(role:'test-role', credentials:'aws_test_user_cred', roleAccount:'182263511292', duration: 900, roleSessionName: 'jenkins-session') {
                        echo "Running terraform init command....."
                        sh ('terraform  -chdir=terraform init') 
                  }
            }
      }
      stage ("Terraform Plan") {
            steps {
                  withAWS(role:'test-role', credentials:'aws_test_user_cred', roleAccount:'182263511292', duration: 900, roleSessionName: 'jenkins-session') {            
                        echo "Running terraform plan command....."
                        sh ('terraform -chdir=terraform plan -var-file=tfvars/dev.tfvars') 
                  }             
            }    
      }
      stage ("Prompt for User Input & Apply") {
            when {
                  expression { 
                        (params.tf_action == 'apply')
                  }
            }
                  steps {
                        script{ 
                              withAWS(role:'test-role', credentials:'aws_test_user_cred', roleAccount:'182263511292', duration: 900, roleSessionName: 'jenkins-session') {          
                                    echo "Waiting for Input from User....."
                                    def userInput
                                    try {
                                          userInput = input(
                                                id: 'Confirm', 
                                                message: 'Do you want to apply Terraform?', 
                                                parameters: [
                                                            [$class: 'BooleanParameterDefinition', 
                                                            defaultValue: true, 
                                                            description: '', 
                                                            name: 'Please confirm you agree with this']
                                                ])
                                          } catch(err) {
                                          userInput = false
                                          echo "Aborted by: ${env.BUILD_USER}"
                                          }
                                          if (userInput == true) {
                                                echo "Applying terraform"
                                                sh ('terraform -chdir=terraform apply -var-file=tfvars/dev.tfvars -auto-approve')
                                          } else {
                                                echo "Terraform apply was not successful."
                                                currentBuild.result = 'FAILURE'
                                          }
                              }
                        }     
                  }       
      }
      stage ("Terraform Destory") {
            when {
                  expression { 
                        (params.tf_action == 'destroy')
                  }
            }            
                  steps {
                        script{ 
                              withAWS(role:'test-role', credentials:'aws_test_user_cred', roleAccount:'182263511292', duration: 900, roleSessionName: 'jenkins-session') {          
                                    echo "Waiting for Input from User....."
                                    def userInput
                                    try {
                                          userInput = input(
                                                id: 'Confirm', 
                                                message: 'Do you want to destory Terraform?', 
                                                parameters: [
                                                            [$class: 'BooleanParameterDefinition', 
                                                            defaultValue: true, 
                                                            description: '', 
                                                            name: 'Please confirm you agree with this']
                                                ])
                                          } catch(err) {
                                          userInput = false
                                          echo "Aborted by: ${env.BUILD_USER}"
                                          }
                                          if (userInput == true) {
                                                echo "Destroying terraform"
                                                sh ('terraform -chdir=terraform destroy -var-file=tfvars/dev.tfvars -auto-approve')
                                          } else {
                                                echo "Terraform apply was not successful."
                                                currentBuild.result = 'FAILURE'
                                          }
                              }
                        }     
                  }    
      } 
  }
      post { 
        always { 
            deleteDir()
            }
      }
}

