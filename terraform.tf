terraform {
  required_version = "~>1.16.0"

  required_providers {
    aws = {
      version = "~> 4.67.0"
      source  = "hashicorp/aws"
    }
    null = {
      version = "~> 3.3.1"
      source  = "hashicorp/null"
    }
    random = {
      version = "~> 3.9.0"
      source  = "hashicorp/random"
    }
    tls = {
      version = "~> 3.4.0"
      source  = "hashicorp/tls"
    }
    template = {
      version = "~> 2.4.0"
      source  = "hashicorp/cloudinit"
    }
    local = {
      version = "~> 2.9.0"
      source  = "hashicorp/local"
    }
  }
}