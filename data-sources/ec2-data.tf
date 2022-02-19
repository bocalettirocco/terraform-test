provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "amzn2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

variable "serverType" {
  type = "string"
  default = "t3.nano"
}

resource "aws_instance" "myec2" {
  ami           = data.aws_ami.amzn2.id
  instance_type = var.serverType
}