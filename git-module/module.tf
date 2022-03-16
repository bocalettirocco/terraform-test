variable "github_token" {
  type = string
  nullable = false
}

module "test" {
  source = "git::https://github.com/bocalettirocco/terraform-test//basic-providers"
  github_token = var.github_token
}