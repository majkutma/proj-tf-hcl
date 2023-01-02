terraform {
  # cloud {
  #   organization = "marekmajkut"
  #   workspaces {
  #     name = "proj-tf-hcl"
  #   }
  # }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["C:/Users/fvg3843/.aws/credentials"]
  profile = "private"
  default_tags {
    tags = {
      apms-id = "example"
      application-name = "example"
      application-owner = "example"
      asec-f = "example"
      business-unit-n1 = "example"
      business-unit-n2 = "example"
      environment-id = "example"
      it-technical-owner = "example"
      version = "example"
      responsible-person = "example"
      deployment-option = "example"
    }
  }
}