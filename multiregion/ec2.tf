data "aws_ami" "ubuntu-latest" {
  provider = aws.virginia
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

resource "aws_instance" "ec2-1" {
  provider = aws.virginia
  ami = data.aws_ami.ubuntu-latest.id
  instance_type = "t3.nano"
}

resource "aws_instance" "ec2-2" {
  provider = aws.ohio
  ami = data.aws_ami.ubuntu-latest.id
  instance_type = "t3.nano"
}