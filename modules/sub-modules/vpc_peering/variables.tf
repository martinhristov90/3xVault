variable "hq_vault_region" {
  description = "The region of the Vault primary cluster"
}

variable "dr_vault_region" {
  description = "The region of the DR cluster for Vault"
}

variable "pr_vault_region" {
  description = "The region for PR clustr for Vault"
}

variable "random_id" {
  type        = string
  description = "Variable used as unique identifier of the current environment"
}