# Initiating the VPC peering from the HQ region to the DR region
resource "aws_vpc_peering_connection" "peering_source_to_dr" {

  provider = aws.hq_provider

  vpc_id      = element(tolist(data.aws_vpcs.vpc_id_hq_region.ids), 0)
  peer_vpc_id = element(tolist(data.aws_vpcs.vpc_id_dr_region.ids), 0)
  peer_region = local.dr_vault_region
  auto_accept = false

  tags = {
    Name = "vault-${local.hq_vault_region}-${var.random_id}"
  }
}

# Accepting the VPC peering request from the DR VPC side
resource "aws_vpc_peering_connection_accepter" "peer_dr" {
  provider = aws.dr_provider

  vpc_peering_connection_id = aws_vpc_peering_connection.peering_source_to_dr.id
  auto_accept               = true

  tags = {
    Name = "vault-${local.hq_vault_region}-${var.random_id}"
  }
}

## Setting options for the VPC peering requester side (HQ)
#resource "aws_vpc_peering_connection_options" "options_dr_requester" {
#  provider = aws.hq_provider
#
#  vpc_peering_connection_id = aws_vpc_peering_connection.peering_source_to_dr.id
#
#  requester {
#    allow_remote_vpc_dns_resolution = true
#  }
#
#  depends_on = [aws_vpc_peering_connection_accepter.peer_dr]
#}
#
## Setting options for the VPC peering acceptor side (DR)
#resource "aws_vpc_peering_connection_options" "options_dr_acceptor" {
#  provider = aws.dr_provider
#
#  vpc_peering_connection_id = aws_vpc_peering_connection.peering_source_to_dr.id
#
#  requester {
#    allow_remote_vpc_dns_resolution = true
#  }
#
#  depends_on = [aws_vpc_peering_connection_accepter.peer_dr]
#
#}

# Initiating the VPC peering from the HQ region to the PR region
resource "aws_vpc_peering_connection" "peering_source_to_pr" {

  provider = aws.hq_provider

  vpc_id      = element(tolist(data.aws_vpcs.vpc_id_hq_region.ids), 0)
  peer_vpc_id = element(tolist(data.aws_vpcs.vpc_id_pr_region.ids), 0)
  peer_region = local.pr_vault_region
  auto_accept = false

  tags = {
    Name = "vault-${local.hq_vault_region}-${var.random_id}"
  }
}

# Accepting the VPC peering request from the PR side
resource "aws_vpc_peering_connection_accepter" "peer_pr" {
  provider = aws.pr_provider

  vpc_peering_connection_id = aws_vpc_peering_connection.peering_source_to_pr.id
  auto_accept               = true

  tags = {
    Name = "vault-${local.hq_vault_region}-${var.random_id}"
  }
}

## Setting options for the VPC peering requester side (HQ)
#resource "aws_vpc_peering_connection_options" "options_pr_requester" {
#  provider = aws.hq_provider
#
#  vpc_peering_connection_id = aws_vpc_peering_connection.peering_source_to_pr.id
#
#  requester {
#    allow_remote_vpc_dns_resolution = true
#  }
#
#  depends_on = [aws_vpc_peering_connection_accepter.peer_pr]
#}
#
## Setting options for the VPC peering acceptor side (DR)
#resource "aws_vpc_peering_connection_options" "options_pr_acceptor" {
#  provider = aws.dr_provider
#
#  vpc_peering_connection_id = aws_vpc_peering_connection.peering_source_to_pr.id
#
#  requester {
#    allow_remote_vpc_dns_resolution = true
#  }
#
#  depends_on = [aws_vpc_peering_connection_accepter.peer_pr]
#}

# VPC peering from DR region to PR region
# Initiating the VPC peering from the HQ region to the DR region
resource "aws_vpc_peering_connection" "peering_dr_to_pr" {

  provider = aws.dr_provider

  vpc_id      = element(tolist(data.aws_vpcs.vpc_id_dr_region.ids), 0)
  peer_vpc_id = element(tolist(data.aws_vpcs.vpc_id_pr_region.ids), 0)
  peer_region = local.pr_vault_region
  auto_accept = false

  tags = {
    Name = "vault-${local.dr_vault_region}-${var.random_id}"
  }
}

# Accepting the VPC peering request from the DR VPC side
resource "aws_vpc_peering_connection_accepter" "peer_dr_pr" {
  provider = aws.pr_provider

  vpc_peering_connection_id = aws_vpc_peering_connection.peering_dr_to_pr.id
  auto_accept               = true

  tags = {
    Name = "vault-${local.dr_vault_region}-${var.random_id}"
  }
}