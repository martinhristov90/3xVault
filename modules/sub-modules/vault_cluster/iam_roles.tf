# This file creates a role and attaches policies to it, so this role can be assumed by the EC2 in which Vault is running. The role is going to be used to access the AWS endpoints.
# Policy that allows EC2 service to assume the role
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# When the role is assumed, the EC2 instance needs the actions described below in order to decrypt and encrypt with symetric key.
data "aws_iam_policy_document" "vault-kms-unseal" {
  statement {
    sid       = "VaultKMSUnseal"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey",
    ]
  }
}

resource "aws_iam_role" "vault-kms-unseal-role" {
  name               = "vault-role-${var.region}-${var.random_id}"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Attaching the policy to the role, this policy is `inline` to the role, not going to show in policies tab
resource "aws_iam_role_policy" "vault-kms-unseal-role-policy" {
  name   = "vault-policy-${var.region}-${var.random_id}"      # Just a name
  role   = aws_iam_role.vault-kms-unseal-role.id              # The id of the role
  policy = data.aws_iam_policy_document.vault-kms-unseal.json # Actual policy that allows to use KMS
}

# This instance profile is used at launch of EC2, so it can assume the created role, and use it to access the KMS, in order to encrypt and decrypt the Vault seal master key
resource "aws_iam_instance_profile" "vault-instance-profile" {
  name = "vault-instance-profile-${var.region}-${var.random_id}"
  role = aws_iam_role.vault-kms-unseal-role.name
}