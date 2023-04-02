pipeline {
  agent any
  stages {
    stage ("Test Stage") {
      steps {
        echo "Hello Test"
      }
    }
//Terraform Stages started 

stage ("Terraform Init ") {
      steps {
            echo "terraform init"
         }
}

stage ("Terraform Plan") {
      steps {
            echo "terraform plan -var-file=tfvars/dev.tfvars"
         }    
}

stage ("Prompt for input") {
      steps {
            echo "UserINPUt"
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

//Terraform Stages finished 



  }
}
