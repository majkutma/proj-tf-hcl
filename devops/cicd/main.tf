terraform {
  cloud {
    organization = "marekmajkut"
    workspaces {
      name = "proj_tf_hcl"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}
module "my_s3_bucket_id" {
  source = "./modules/resource_id"
  branch_name = var.git_branch_name
  resource_name = "my_s3_bucket"
}
resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = module.my_s3_bucket_id.resource_id
}
resource "aws_s3_bucket_acl" "my_s3_bucket_acl" {
  bucket = aws_s3_bucket.my_s3_bucket.id
  acl    = "private"
}