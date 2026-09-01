variable "random_id" {
  type        = string
  description = "Variable used as unique identifier of the current environment"
}

variable "clusters" {
  # Only the attributes consumed by this module are declared here.
  # The root module passes the full clusters map (which contains additional
  # attributes such as vault_version and vault_ec2_type); Terraform's type
  # system allows the extra attributes through when the caller's type is a
  # superset of the declared type.
  type = map(object({
    region   = string
    vpc_cidr = string
  }))

  description = "Map of Vault clusters. Only 'region' and 'vpc_cidr' are used by this module."
}
