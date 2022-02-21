provider "aws" {
  region = "us-east-1"
}

variable "subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
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

variable "ingress_ports" {
  type    = list(number)
  default = [22,80]
}

resource "aws_key_pair" "login" {
  key_name   = "login"
  public_key = file("${path.module}/fake.pub")
}

resource "aws_security_group" "admin" {
  name = "admin"
  vpc_id      = var.vpc_id
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
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "myec2" {
  ami           = data.aws_ami.amzn2.id
  instance_type = "t3.nano"
  key_name      = aws_key_pair.login.key_name
  vpc_security_group_ids = [aws_security_group.admin.id]
  subnet_id = var.subnet_id
  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1.12",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("${path.module}/../../fake")
      host        = self.public_ip
    }
  }
}