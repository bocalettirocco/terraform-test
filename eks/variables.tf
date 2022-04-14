variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "app" {
  type    = string
  default = "eks-test"
}

variable "region" {
  type    = string
  default = "us-east-2"
}

variable "availability_zones_count" {
  type    = number
  default = 2
}

variable "subnet_cidr_bits" {
  type    = number
  default = 8
}

variable "kubernetes_version" {
  type    = string
  default = "1.21"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    "App"     = "TerraformEKS"
    "Environment" = "Development"
    "Owner"       = "Mario Bocaletti"
  }
}