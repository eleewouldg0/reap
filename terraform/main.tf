terraform {
  required_version = ">= 1.5.0"
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

# DEMO-FINDING: bucket has no public-access block and no default encryption.
# IaC scanners (Upwind, tfsec, Checkov) should flag both.
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "upwind-demo-bucket-${var.environment}"
}

resource "aws_s3_bucket_acl" "demo_bucket_acl" {
  bucket = aws_s3_bucket.demo_bucket.id
  acl    = "public-read"
}

# DEMO-FINDING: security group open to the world on SSH.
resource "aws_security_group" "demo_sg" {
  name        = "upwind-demo-sg"
  description = "Demo security group with an intentionally open ingress rule"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from anywhere (DEMO-FINDING)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# DEMO-FINDING: unencrypted EBS volume on the instance.
resource "aws_instance" "demo_instance" {
  ami                    = var.ami_id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.demo_sg.id]

  root_block_device {
    volume_size = 20
    encrypted   = false
  }

  tags = {
    Name        = "upwind-demo-instance"
    Environment = var.environment
  }
}
