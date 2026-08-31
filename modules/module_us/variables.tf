variable "random_id" {
  type        = string
  description = "Variable used as unique identifier of the current environment"
}

variable "region" {
  type        = string
  description = "Region where the cluster is deployed"
}

variable "vault_common_ca_cert" {
  type        = string
  description = "CA certificate to sign Vault server certificates"
}

variable "vault_common_ca_private_key" {
  type        = string
  description = "CA private used to sign Vault server certificates"
}

variable "vault_license" {
  type        = string
  description = "Vault license"
}

variable "vault_version" {
  type        = string
  description = "Version of the Vault binary to be used"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR of the VPC"
}

variable "vault_ec2_type" {
  type        = string
  description = "EC2 instance type"
}

variable "use_private_image" {
  description = "Enables the usage of proprietary image (if accessible) rather than Ubuntu, used for testing within organization"
  type        = bool
}