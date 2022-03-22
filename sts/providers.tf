variable "role" {
  type = string
}

provider "aws" {
  region = "us-east-1"
  assume_role {
    role_arn = var.role
    session_name = "test"
  }
}
