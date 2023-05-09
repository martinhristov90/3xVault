terraform {
  required_version = "~>1.4.4"

  required_providers {
    aws = {
      version = "~> 4.20.1"
      source  = "hashicorp/aws"
    }
    null = {
      version = "~> 3.1.1"
      source  = "hashicorp/null"
    }
    random = {
      version = "~> 3.3.2"
      source  = "hashicorp/random"
    }
    tls = {
      version = "~> 3.4.0"
      source  = "hashicorp/tls"
    }
    template = {
      version = "~> 2.2.0"
      source  = "hashicorp/cloudinit"
    }
    local = {
      version = "~> 2.2.3"
      source  = "hashicorp/local"
    }
  }
}