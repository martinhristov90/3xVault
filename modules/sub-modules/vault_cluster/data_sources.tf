# Find all availability zones in the region
data "aws_availability_zones" "available" {
  state = "available"
}

# Getting the latest Ubuntu image
data "aws_ami" "ubuntu" {
  most_recent = "true"
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Getting subnets cidr blocks
data "aws_subnet" "subnets" {
  for_each = local.availability_zones_sliced # each subnet

  id = aws_subnet.public_subnet[each.key].id
}

# Getting the AWS account ID, it is used to create a policy and make sure that the AWS secrets engine has only permissions on IAM accounts that start with "vault-"
data "aws_caller_identity" "current_aws_account" {}

# Getting the ARN for DemoUser permission boundary policy
data "aws_iam_policy" "demouser" {
  name = "DemoUser"
}