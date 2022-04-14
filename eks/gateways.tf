# INTERNET
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${var.app}-igw"
  }

  depends_on = [aws_vpc.this]
}

# NAT EIP
resource "aws_eip" "main" {
  vpc = true

  tags = {
    Name = "${var.app}-ngw-ip"
  }
}

# NAT
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${var.app}-ngw"
  }
}