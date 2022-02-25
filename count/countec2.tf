provider "aws" {
  region = "us-east-1"
}

variable "names" {
  type = list
  default = ["dev", "qa", "uat"]
}

resource "aws_instance" "bastion" {
  ami = data.aws_ami.ubuntu-latest.id
  instance_type = "t3.nano"

  tags = {
    Name = format("%s%s","bastion-",var.names[count.index])
  }

  count = 3
}