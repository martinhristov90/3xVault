
# Creating 3 Vault instances in each AZ
resource "aws_instance" "vault" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  for_each      = local.availability_zones_sliced
  subnet_id     = aws_subnet.public_subnet[each.key].id # Subnet for the EC2 
  key_name      = aws_key_pair.vault-ssh-key.key_name   # Waiting on the key to be created first

  vpc_security_group_ids      = [aws_security_group.vault.id]
  associate_public_ip_address = true
  ebs_optimized               = false
  # The intance profile is going to give the EC2 (using meta-data) short-lived STS credentials to access the AWS IAM
  # Credentials are available locally for the EC2 at : http://169.254.169.254/latest/meta-data/iam....
  iam_instance_profile = aws_iam_instance_profile.vault-instance-profile.id

  tags = {
    Name = "vault-${var.region}-${each.key}-${var.random_id}"
  }
  # Provisioning Vault
  user_data = data.template_cloudinit_config.myhost[each.key].rendered
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

