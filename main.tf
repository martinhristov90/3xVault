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

module "inter_vpc_peering" {
  source = "./modules/sub-modules/vpc_peering"

  hq_vault_region = var.clusters.us.region
  dr_vault_region = var.clusters.eu.region
  pr_vault_region = var.clusters.ap.region

  random_id = local.random_id

  # Workaround in order `depends_on` to work
  providers = {
    aws.hq_provider = aws.hq_provider
    aws.dr_provider = aws.dr_provider
    aws.pr_provider = aws.pr_provider
  }

  depends_on = [module.vault-cluster-ap, module.vault-cluster-eu, module.vault-cluster-us]
}