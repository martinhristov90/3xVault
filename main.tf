module "vault-cluster-us" {

  source = "./modules/module_us"

  vault_common_ca_cert        = local.vault_common_ca_cert
  vault_common_ca_private_key = local.vault_common_ca_private_key
  random_id                   = local.random_id
  vault_license               = local.vault_license

  region   = var.clusters.us.region
  vpc_cidr = var.clusters.us.vpc_cidr

}

module "vault-cluster-eu" {

  source = "./modules/module_eu"

  vault_common_ca_cert        = local.vault_common_ca_cert
  vault_common_ca_private_key = local.vault_common_ca_private_key
  random_id                   = local.random_id
  vault_license               = local.vault_license

  region   = var.clusters.eu.region
  vpc_cidr = var.clusters.eu.vpc_cidr

}

module "vault-cluster-ap" {

  source = "./modules/module_ap"

  vault_common_ca_cert        = local.vault_common_ca_cert
  vault_common_ca_private_key = local.vault_common_ca_private_key
  random_id                   = local.random_id
  vault_license               = local.vault_license

  region   = var.clusters.ap.region
  vpc_cidr = var.clusters.ap.vpc_cidr

}