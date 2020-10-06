module "vault-cluster-us" {
    source = "./modules/module_us"

    vault_common_ca_cert = module.vault_common_ca.vault_common_ca_cert
    vault_common_ca_private_key = module.vault_common_ca.common_ca_private_key
    random_id = random_pet.env.id

    vault_license = file("./license_vault.txt")
}

