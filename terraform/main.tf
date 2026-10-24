terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.53"
    }
  }
backend "s3" {
    bucket         = "mjay-s3-bucket"
    key            = "environment/dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    use_lockfile   = true  # Enables S3 native locking (Terraform 1.10+)
  }
}

provider "aws" {
  region = "us-east-1" # Replace with your target AWS region
}


module "ec2_provisioning" {
source = "./modules/ec2_instance"
tags = ["jenkins-master","jenkins-agent"]
}
