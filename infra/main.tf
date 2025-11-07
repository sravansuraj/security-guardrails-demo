# Intentionally insecure Terraform for tfsec testing

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

# ❌ Security Group open to the world (tfsec will flag this)
resource "aws_security_group" "demo_sg" {
  name        = "tfsec-demo-sg"
  description = "Intentionally open ingress for tfsec test"

  ingress {
    description = "SSH from anywhere"
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

# ❌ S3 bucket without encryption (tfsec will flag this)
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "tfsec-demo-bucket"
}
# Intentionally insecure Terraform for tfsec testing

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

# ❌ Security Group open to the world (tfsec will flag this)
resource "aws_security_group" "demo_sg" {
  name        = "tfsec-demo-sg"
  description = "Intentionally open ingress for tfsec test"

  ingress {
    description = "SSH from anywhere"
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

# ❌ S3 bucket without encryption (tfsec will flag this)
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "tfsec-demo-bucket"
}
