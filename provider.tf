terraform {
  required_version = ">= 1.13.0"

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile
}
