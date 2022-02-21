terraform {
  required_version = ">=0.12"
  required_providers {
    aws = "~> 4.0"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "lb" {
  name = "iamuser.${count.index}"
  count = 3
  path = "/system/"
}

output "iam_names" {
  value = aws_iam_user.lb[*].name
}

output "iam_arns" {
  value = aws_iam_user.lb[*].arn
}