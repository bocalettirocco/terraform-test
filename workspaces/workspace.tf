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

resource "aws_instance" "myec2" {
  ami = data.aws_ami.ubuntu-latest.id
  instance_type = lookup(var.instance_type, terraform.workspace)
}

variable "instance_type" {
  type = map

  default = {
    default = "t2.nano"
    dev = "t2.nano"
    prod = "t2.micro"
  }
}