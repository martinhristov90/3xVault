# Defining VPC
# tfsec:ignore:aws-ec2-require-vpc-flow-logs-for-all-vpcs - VPC Flow Logs will be configured separately based on environment requirements
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "vault-${var.region}-${var.random_id}"
  }
}