provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu-latest" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

variable "names" {
  type    = list(any)
  default = ["dev", "qa", "uat"]
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu-latest.id
  instance_type = "t3.nano"

  tags = {
    Name = format("%s%s", "bastion-", var.names[count.index])
  }

  count = 3
}

output "name_arn" {
  value = zipmap(aws_instance.bastion[*].tags.Name, aws_instance.bastion[*].arn)
}