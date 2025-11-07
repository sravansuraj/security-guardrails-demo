# Secure Terraform for tfsec passing

terraform {
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

# ✅ FIXED: Restricted ingress (no 0.0.0.0/0)
resource "aws_security_group" "demo_sg" {
  name        = "tfsec-demo-sg"
  description = "Restricted ingress for tfsec test"

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ✅ FIXED: S3 bucket WITH encryption enabled
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "tfsec-demo-bucket"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_enc" {
  bucket = aws_s3_bucket.demo_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
