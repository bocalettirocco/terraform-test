provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "labs-bucket"
    key    = "terraform/remote-backend.tfstate"
    region = "us-east-1"
    dynamodb_table = "s3-state-lock"
  }
}

resource "aws_eip" "lb" {
  vpc = true
}