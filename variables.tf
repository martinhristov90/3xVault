variable "clusters" {
  type = map(object({
    region         = string
    vpc_cidr       = string
    vault_version  = string
    vault_ec2_type = string
  }))

  description = "Defines all Vault clusters, map of custom objects"

  validation {
    condition     =  alltrue([for version in [for cluster in var.clusters: cluster.vault_version] : can(regex("^([0-9]\\.[0-9]{1,2}?\\.[0-9]\\+ent\\-[0-9])$", version))])
    error_message = "Please, enter correct version of Vault"
  }
}
