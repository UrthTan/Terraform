terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "my-s3-bucket-urth-henry-001"
  versioning {
    enabled = true
  }
}

resource "aws_iam_user" "my_iam_user" {
  for_each = toset(var.users)
  name     = each.value
}

resource "aws_security_group" "http_server_security_group" {
  name   = "http_server_security_group"
  vpc_id = "vpc-680b7515"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "http_server_security_group"
  }
}