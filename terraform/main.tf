terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.53"
    }
  }
}

# The default, un-aliased provider configuration
provider "aws" {
  region = "us-east-1" # Replace with your target AWS region
}

resource "aws_instance" "example_server" {
  ami           = "ami-001f5bddaefcc0e28" # Replace with a valid AMI ID for your region
  instance_type = "t2.micro"             # Free tier eligible instance type
  availability_zone = "us-east-1a"

  tags = {
    Name = "My-Terraform-EC2"
  }
}



resource "aws_ebs_volume" "example" {
  availability_zone = aws_instance.example_server.availability_zone # Dynamic reference matching instance AZ
  size              = 11
  type              = "gp3"

  tags = {
    Name = "Extra-Storage"
  }
}


resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.example_server.id
}
