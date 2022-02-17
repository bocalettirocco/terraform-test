provider "aws" {
  region = "us-east-1"
}

data "aws_region" "current" {}

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

variable "list" {
  type = list
  default = ["m5.large","m5.xlarge","t2.medium"]
}

variable "types" {
  type = map
  default = {
    us-east-1 = "t2.micro"
    us-east-2 = "t2.nano"
    ap-south-1 = "t2.small"
  }
}

resource "aws_instance" "myec2" {
  ami = data.aws_ami.ubuntu-latest.id
  instance_type = var.types["${data.aws_region.current.name}"]
}