data "aws_vpcs" "vpc_id_hq_region" {
  provider = aws.hq_provider
  tags = {
    Name = "vault-${var.hq_vault_region}-${var.random_id}"
  }
}

data "aws_vpcs" "vpc_id_dr_region" {
  provider = aws.dr_provider
  tags = {
    Name = "vault-${var.dr_vault_region}-${var.random_id}"
  }
}

data "aws_vpcs" "vpc_id_pr_region" {
  provider = aws.pr_provider
  tags = {
    Name = "vault-${var.pr_vault_region}-${var.random_id}"
  }
}