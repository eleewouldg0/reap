variable "aws_region" {
  description = "AWS region to deploy the demo resources into"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name tag"
  type        = string
  default     = "demo"
}

variable "vpc_id" {
  description = "VPC ID to place the demo security group in"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the demo EC2 instance"
  type        = string
}
