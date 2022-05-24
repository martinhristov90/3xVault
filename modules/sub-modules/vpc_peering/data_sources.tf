# Getting the Vault VPC id for the HQ region
data "aws_vpcs" "vpc_id_hq_region" {
  provider = aws.hq_provider
  tags = {
    Name = "vault-${local.hq_vault_region}-${var.random_id}"
  }
}

# Getting the Vault VPC id for the DR region
data "aws_vpcs" "vpc_id_dr_region" {
  provider = aws.dr_provider
  tags = {
    Name = "vault-${local.dr_vault_region}-${var.random_id}"
  }
}

# Getting the Vault VPC id for the PR region
data "aws_vpcs" "vpc_id_pr_region" {
  provider = aws.pr_provider
  tags = {
    Name = "vault-${local.pr_vault_region}-${var.random_id}"
  }
}

# Getting the Route tables IDs, so routes to the oppsite sides can be added
data "aws_route_table" "route_table_id_hq_region" {
  provider = aws.hq_provider
  vpc_id   = element(tolist(data.aws_vpcs.vpc_id_hq_region.ids), 0)

  filter {
    name   = "tag:Name"
    values = ["vault-*"]
  }
}

data "aws_route_table" "route_table_id_dr_region" {
  provider = aws.dr_provider
  vpc_id   = element(tolist(data.aws_vpcs.vpc_id_dr_region.ids), 0)
  filter {
    name   = "tag:Name"
    values = ["vault-*"]
  }
}

data "aws_route_table" "route_table_id_pr_region" {
  provider = aws.pr_provider
  vpc_id   = element(tolist(data.aws_vpcs.vpc_id_pr_region.ids), 0)
  filter {
    name   = "tag:Name"
    values = ["vault-*"]
  }
}