terraform {
  required_version = "~>1.16.0"

  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.9.0"
    }
  }
}