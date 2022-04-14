resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name                                       = "${var.app}-vpc",
    "kubernetes.io/cluster/${var.app}-cluster" = "shared"
  }
}