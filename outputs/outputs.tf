provider "aws" {
  region = "us-east-1"
}

resource "aws_eip" "lb" {
  vpc = true
}

output "eip" {
  value = aws_eip.lb.public_ip
}

resource "aws_s3_bucket" "s3" {
  bucket = "test-bucket-bocalettirocco"
}

output "tests3bucket" {
  value = aws_s3_bucket.s3.bucket_domain_name
}
