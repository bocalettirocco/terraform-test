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

locals {
  common_tags = {
    Env = var.env
    Name = "cluster-node"
  }
}

resource "aws_instance" "node1" {
  ami = data.aws_ami.ubuntu-latest.id
  instance_type = "t3.nano"

  tags = local.common_tags
}

resource "aws_instance" "node2" {
  ami = data.aws_ami.ubuntu-latest.id
  instance_type = "t3.nano"

  tags = local.common_tags
}