provider "aws" {
  region = "us-east-1" # Replace with your target AWS region
}


module "ec2_provisioning" {
source = ./modules/ec2_instance
tags = ["jenkins-master","jenkins-agent"]
}
