# Creating subnet in each AZ
resource "aws_subnet" "public_subnet" {
  for_each = local.availability_zones_sliced

  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr, 4, index(tolist(local.availability_zones_sliced), each.key))
  # when set is used for for_each each.key and each.value are the same
  availability_zone       = each.value
  map_public_ip_on_launch = true

  tags = {
    Name = "vault-${var.region}-${each.key}-${var.random_id}"
  }
}