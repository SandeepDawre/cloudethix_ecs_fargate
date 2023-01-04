terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.46.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
provider "random" {
  # Configuration options
}
provider "null" {
  # Configuration options
}
