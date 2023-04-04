pipeline {
  agent any
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
            steps {
                  script{ 
                        withAWS(role:'test-role', credentials:'aws_test_user_cred', roleAccount:'182263511292', duration: 900, roleSessionName: 'jenkins-session') {          
                              echo "Waiting for Input from User....."
                              try {
                                    def userInput = input(
                                          id: 'Confirm', 
                                          message: 'Do you want to apply Terraform?', 
                                          parameters: [
                                                      [$class: 'BooleanParameterDefinition', 
                                                      defaultValue: true, 
                                                      description: '', 
                                                      name: 'Please confirm you agree with this']
                                          ])
                                    } catch(err) {
                                    def user = err.getCauses()[0].getUser()
                                    userInput = false
                                    echo "Aborted by: [${user}]"
                                    }
                                    //node {
                                    if (userInput == true) {
                                          echo "Applying terraform"
                                    } else {
                                          echo "Terraform apply was not successful."
                                          currentBuild.result = 'FAILURE'
                                    }
                                    //}
                        }
                  }     
            }       
      }

      stage ("Terraform Apply") {
            steps {
                  echo "terraform apply -var-file=tfvars/dev.tfvars"
            }    
      }
      stage ("Terraform Destory") {
            steps {
                  echo "Userput"
                  echo "terraform destroy -var-file=tfvars/dev.tfvars"
            }    
      } 
  }
      post { 
        always { 
            deleteDir()
            }
      }
}

