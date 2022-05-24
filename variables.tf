variable "clusters" {
  type = map(object({
    region        = string
    vpc_cidr      = string
    vault_version = string
  }))

  description = "Defines all Vault clusters, map of custom objects"
}
