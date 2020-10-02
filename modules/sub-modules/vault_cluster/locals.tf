# Getting the first three AZs
locals {
  availability_zones_sliced = toset(slice(data.aws_availability_zones.available.names, 0, 3))
}
# Defining algorithms for host keys
locals {
  algorithms = ["RSA", "ECDSA"]
}


