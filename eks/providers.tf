terraform {
  backend "s3" {
    bucket         = "labs-bucket"
    dynamodb_table = "terraform-state"
    key            = "terraform/eks.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }

  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}