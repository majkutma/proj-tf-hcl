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
provider "aws" {
  region = "us-east-1"
}