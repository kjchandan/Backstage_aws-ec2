variable "instance_name" {
  description = "Name for the EC2 instance"
  type        = string
  default     = "my-ec2-instance"
}

variable "instance_description" {
  description = "Description for the EC2 instance"
  type        = string
  default     = "Simple EC2 instance created by Backstage"
}

variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type - fixed to t2.micro for simplicity"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance - Amazon Linux 2023"
  type        = string
  default     = "ami-0c02fb55956c7d316"
}

variable "key_pair_name" {
  description = "Name of the AWS key pair for SSH access"
  type        = string
  default     = ""
}
