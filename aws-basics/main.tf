terraform {
  required_providers {
      aws = {
          source = "hashicorp/aws"
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

resource "aws_iam_user" "my_iam_user"{ 
    name = "my-iam-user-urth-henry-001"
}

output "my_iam_user_complete_details" {
    value = aws_iam_user.my_iam_user
}