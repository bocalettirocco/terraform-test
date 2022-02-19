provider "aws" {
  region = "us-east-1"
}

variable "ingress_ports" {
  type    = list(number)
  default = [80, 443]
}

resource "aws_security_group" "alb" {
  name = "alb-sg-terraform"

  dynamic "ingress" {
    for_each = var.ingress_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}