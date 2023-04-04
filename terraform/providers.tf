terraform {
    backend "s3" {
    bucket = "cloudethix-terraform-state-bucket007"
    key    = "terrform/jenkins/dev/terraform.tfstate"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.46.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
}