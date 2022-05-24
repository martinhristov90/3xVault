variable "vpc_cidr" {
  description = "CIDR of the VPC"
}

variable "random_id" {
  type        = string
  description = "Variable used as unique identifier of the current environment"
}

variable "region" {
  type        = string
  description = "Region where the cluster is deployed"
}

variable "log_level" {
  default     = "DEBUG"
  description = "Sets Vault log level"
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
  description = "Version of the Vault binary version to be used"
}