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

# S3 Bucket
resource "aws_s3_bucket" "backend_state" {
  bucket = "dev-backend-state-s3-bucket-urth-001"
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# Locking - Dynamo DB
resource "aws_dynamodb_table" "backend_loc" {
  name = "dev_application_lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

# 3 IAM Users
resource "aws_iam_user" "my_iam_user" {
  for_each = toset(var.users)
  name     = each.value
}


