terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" # Make sure this matches your GitHub Secret region
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_instance" "my_first_server" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = "t2.micro" # This is usually Free Tier eligible

  tags = {
    Name = "Terraform-Learning-Server"
  }
}
