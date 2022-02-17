provider "aws" {
  region = "us-east-1"
}

variable "vpn" {
  default = "110.80.80.1/32"
}

resource "aws_security_group" "sg_var" {
  name = "sg_var"

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [var.vpn]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [var.vpn]
  }

  ingress {
    from_port = 53
    to_port = 53
    protocol = "udp"
    cidr_blocks = [var.vpn]
  }
}

