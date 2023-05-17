locals {
  # Deployment is using the random_pet for tagging resourcres
  random_id = random_pet.env.id
  # Putting the CA cert in a local variable
  vault_common_ca_cert = module.vault_common_ca.vault_common_ca_cert
  # Putting the CA key in a local variable
  vault_common_ca_private_key = module.vault_common_ca.common_ca_private_key
  # Use empty license if the license file `license_vault.txt` does not exists
  empty_license = ""
  # Reading Vault license file, if it does not exists, OSS Vault will be used 
  vault_license = var.vault_license
}