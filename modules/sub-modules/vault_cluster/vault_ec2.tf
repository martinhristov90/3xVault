
# Creating 3 Vault instances in each AZ
resource "aws_instance" "vault" {

  for_each = local.availability_zones_sliced

  ami           = var.use_private_image ? data.aws_ami.hc_base_ubuntu_2404[0].id : data.aws_ami.ubuntu[0].id
  instance_type = local.vault_ec2_type
  subnet_id     = aws_subnet.public_subnet[each.key].id # Subnet for the EC2 
  key_name      = aws_key_pair.vault_ssh_key.key_name   # Waiting on the key to be created first

  vpc_security_group_ids      = [aws_security_group.vault.id]
  associate_public_ip_address = true
  ebs_optimized               = false
  private_ip                  = cidrhost(data.aws_subnet.subnets[each.key].cidr_block, 5) # Giving EC2 the 5th IP of each subnet, the first 4 and the last 4 IPs of each subnet are reserved by AWS

  # The intance profile is going to give the EC2 (using meta-data) short-lived STS credentials to access the AWS IAM
  # Credentials are available locally for the EC2 at : http://169.254.169.254/latest/meta-data/iam....
  iam_instance_profile = aws_iam_instance_profile.vault_instance_profile.id

  tags = {
    Name = "vault-${var.region}-${each.key}-${var.random_id}"
  }
  # Provisioning Vault.
  # user_data_base64 is used instead of user_data because the cloudinit_config data source
  # renders a gzip+base64-encoded blob (gzip=true, base64_encode=true in cloud_init.tf).
  # The user_data attribute validates the value as a plain string and enforces a 16,384-character
  # limit on that string, which the base64 representation of the compressed payload exceeds.
  # user_data_base64 accepts a pre-encoded base64 value and passes it directly to the EC2 API,
  # bypassing the string-length check. AWS still enforces ≤16 KiB on the raw (pre-base64) payload,
  # which the gzip-compressed cloud-init config satisfies.
  user_data_base64 = data.cloudinit_config.myhost[each.key].rendered
}

# Getting the AWS account id

#data "aws_caller_identity" "current" {}
#
## Installing and provisioning Vault with this template file
#data "template_file" "vault" {
#  template = file("userdata.tpl")
#
#  vars = {
#    vault_url  = var.vault_url
#    aws_region = var.aws_region
#    VAULT_ADDR = "http://127.0.0.1:8200"
#    aws_account_id = data.aws_caller_identity.current.account_id
#    create_ami_role_arn = aws_iam_role.create_ami-role.arn
#  }
#}

