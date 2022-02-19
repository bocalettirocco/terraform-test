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

locals {
  time = formatdate("MMM DD YYYY hh:mm ZZZ", timestamp())
}

variable "tags" {
  type = list
  default = ["node1","node2"]
}

resource "aws_key_pair" "login" {
  key_name = "login"
  public_key = file("${path.module}/fake.pub")
}

resource "aws_instance" "node" {
  ami = data.aws_ami.ubuntu-latest.id
  instance_type = "t3.nano"
  key_name = aws_key_pair.login.key_name
  tags = {
    Name = format("%s",var.tags[count.index])
  }

  count = 2
}

output "time_created" {
  value = local.time
}
