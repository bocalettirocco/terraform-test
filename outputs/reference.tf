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
  instance_type = "t3.nano"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id = "${aws_instance.myec2.id}"
  allocation_id = "${aws_eip.lb.id}"
}