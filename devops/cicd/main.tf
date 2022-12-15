terraform {
  cloud {
    organization = "marekmajkut"
    workspaces {
      name = "proj-tf-hcl"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my-demo-s3-bucket123321" {
  bucket = "my-proj-tf-hcl-bucket123321"
}
resource "aws_s3_bucket_acl" "my-demo-s3-bucket123321-acl" {
  bucket = aws_s3_bucket.my-demo-s3-bucket123321.id
  acl    = "private"
}