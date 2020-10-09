variable "random_id" {
  type        = string
  description = "Variable used as unique identifier of the current environment"
}

variable "clusters" {
  type = map(object({
    region   = string
    vpc_cidr = string
  }))

  description = "Defines all Vault clusters, map of custom objects"
}
