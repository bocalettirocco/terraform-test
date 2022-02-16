terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}
variable "github_token" {
  type = string
  nullable = false
}

provider "github" {
  token = var.github_token
  owner = "bocalettirocco"
}

resource "github_repository" "repo" {
  name = "repo"
  description = "test repo"
  visibility = "public"
}