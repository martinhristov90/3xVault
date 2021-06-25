# This file creates a role and instance profile to be used by Vault EC2 intances. The role has permissions for KMS auto-unseal, Raft auto-join, AWS auth (iam type) and AWS secret engine

# Creating a role used by the Vault servers
resource "aws_iam_role" "vault_server_role" {

  name               = "vault-role-${var.region}-${var.random_id}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_vault_ec2.json

  managed_policy_arns = [aws_iam_policy.vault_kms_auto_unseal_policy.arn,aws_iam_policy.vault_raft_auto_join_policy.arn,aws_iam_policy.vault_aws_auth_policy.arn, aws_iam_policy.vault_aws_secret_policy.arn]
  
  tags = {
    Name = "vault-server-role-aws-kms-secrets-auth-${var.region}-${var.random_id}" # All resources will be tagged this way
  }
}

# This instance profile is used at launch of EC2, so it can assume the created role, and use it to access the KMS, in order to encrypt and decrypt the Vault seal master key
resource "aws_iam_instance_profile" "vault-instance-profile" {
  name = "vault-instance-profile-${var.region}-${var.random_id}"
  role = aws_iam_role.vault_server_role.name
}

