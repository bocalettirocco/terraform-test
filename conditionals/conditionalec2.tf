provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu-latest" {
  most_recent = true
  owners = ["099720109477"] # Canonical

  filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}

variable "env" {
  type = string
}

resource "aws_instance" "backend" {
  ami = data.aws_ami.ubuntu-latest.id
  instance_type = var.env == "prod" ? "t3.small" : "t3.nano"

  tags = {
    Name = format("%s%s","backend-",var.env)
  }
}