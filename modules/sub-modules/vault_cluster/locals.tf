# Getting the first three AZs
locals {
  availability_zones_sliced = toset(slice(data.aws_availability_zones.available.names, 0, 3))
}
# Defining algorithms for host keys
locals {
  algorithms = ["RSA", "ECDSA"]
}

# Getting the first AZ
locals {
  first_subnet_host = element(tolist(local.availability_zones_sliced), 0)
}

locals {
  vault_ec2_type = var.vault_ec2_type == "large" ? "t3.large" : "t3.small"
}
