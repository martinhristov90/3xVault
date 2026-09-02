terraform {
  required_version = "~>1.16.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.62.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.4.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.3.1"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.4.0"
    }
  }
}
