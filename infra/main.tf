# Intentionally insecure Terraform (now fixed for tfsec)

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

# Security Group with restricted ingress (fixed)
resource "aws_security_group" "demo_sg" {
  name        = "tfsec-demo-sg"
  description = "Restricted ingress for tfsec test"

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # Restricted instead of 0.0.0.0/0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# S3 bucket (no encryption initially)
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "tfsec-demo-bucket-${random_id.rand.hex}"
}

resource "random_id" "rand" {
  byte_length = 4
}

# Added: S3 bucket default encryption (fix for tfsec)
resource "aws_s3_bucket_server_side_encryption_configuration" "demo_bucket_encryption" {
  bucket = aws_s3_bucket.demo_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
