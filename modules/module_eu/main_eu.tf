provider "aws" {
  alias  = "eu-provider"
  region = var.region
}

module "vault-cluster-eu" {
  source = "../sub-modules/vault_cluster"

  #Variables
  vpc_cidr  = var.vpc_cidr
  random_id = var.random_id
  region    = var.region

  vault_common_ca_cert        = var.vault_common_ca_cert
  vault_common_ca_private_key = var.vault_common_ca_private_key

  vault_license = var.vault_license
  vault_version = var.vault_version

  providers = {
    aws = aws.eu-provider
  }
}