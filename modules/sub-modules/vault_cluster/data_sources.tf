# Find all availability zones in the region
data "aws_availability_zones" "available" {
  state = "available"
}

# Getting the latest Ubuntu image
data "aws_ami" "ubuntu" {
  most_recent = "true"
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
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