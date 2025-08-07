# Configure the AWS Provider
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Data source to get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Data source to get subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Data source to get the default security group
data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}

# EC2 Instance
resource "aws_instance" "main" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name              = var.key_pair_name != "" ? var.key_pair_name : null
  vpc_security_group_ids = [data.aws_security_group.default.id]
  subnet_id             = data.aws_subnets.default.ids[0]

  # Associate public IP
  associate_public_ip_address = true

  # Root block device - small and simple
  root_block_device {
    volume_type = "gp3"
    volume_size = 8
    encrypted   = false
  }

  # Simple user data script
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y htop
              echo "<h1>Hello from ${var.instance_name}!</h1>" > /tmp/hello.html
              EOF

  tags = {
    Name        = var.instance_name
    Description = var.instance_description
    Environment = "development"
    ManagedBy   = "terraform"
    CreatedBy   = "backstage"
  }
}
