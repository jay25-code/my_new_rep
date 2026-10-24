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
  for_each = toset(var.tags)

  ami           = "ami-001f5bddaefcc0e28" # Replace with a valid AMI ID for your region
  instance_type = "t2.micro"             # Free tier eligible instance type
  availability_zone = "us-east-1a"

  tags = {
    Name = "My-Terraform-EC2-${each.key}"
  }
}



resource "aws_ebs_volume" "example" {
  for_each = toset(var.tags)
  availability_zone = aws_instance.example_server[each.key].availability_zone # Dynamic reference matching instance AZ
  size              = 11
  type              = "gp3"

  tags = {
    Name = "Extra-Storage-${each.key}"
  }
}


resource "aws_volume_attachment" "ebs_att" {
  for_each = toset(var.tags)
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example[each.key].id
  instance_id = aws_instance.example_server[each.key].id
}
