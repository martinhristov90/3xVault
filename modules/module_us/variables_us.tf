variable "random_id" {
  type        = string
  description = "Variable used as unique identifier of the current environment"
}

variable "region" {
  description = "Region where the cluster is deployed"
}

variable "vault_common_ca_cert" {
  description = "CA certificate to sign Vault server certificates"
}

variable "vault_common_ca_private_key" {
  description = "CA private used to sign Vault server certificates"
}

variable "vault_license" {
  description = "Vault license"
}

variable "vault_version" {
  description = "Version of the Vault binary to be used"
}

variable "vpc_cidr" {
  description = "CIDR of the VPC"
}

