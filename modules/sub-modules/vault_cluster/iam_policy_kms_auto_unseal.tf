# This file creates a managed policy that allows the usage of KMS services

# Policy document (only in TF) that gives needed KMS permissions for auto-unseal feature
data "aws_iam_policy_document" "vault_kms_unseal" {
  statement {
    sid       = "vaultPolicyDocumentKMSUnseal"
    effect    = "Allow"
    resources = ["${aws_kms_key.vault.arn}"]

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey",
    ]
  }
}

# Creating a managed policy for KMS auto unseal feature
resource "aws_iam_policy" "vault_kms_auto_unseal_policy" {
  name        = "vault-policy-kms-unseal-${var.region}-${var.random_id}"
  path        = "/"
  description = "Policy that provides the needed KMS permission for Vault server's auto unseal feature"

  policy = data.aws_iam_policy_document.vault_kms_unseal.json
}
