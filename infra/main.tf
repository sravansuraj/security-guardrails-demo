# Intentionally insecure Terraform for tfsec demo

terraform {
  required_version = ">= 0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# 1) Security Group with world-open ingress (HIGH finding)
resource "aws_security_group" "demo_sg" {
  name        = "tfsec-demo-sg"
  description = "Intentionally open ingress for tfsec test"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # <- tfsec: aws-vpc-no-public-ingress
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2) S3 bucket without default encryption (HIGH finding)
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "tfsec-demo-bucket-${random_id.rand.hex}"
}

resource "random_id" "rand" {
  byte_length = 4
}
