# Internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "vault-${var.region}-${var.random_id}"
  }
}