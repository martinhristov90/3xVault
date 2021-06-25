# This file creates a managed policy to be used by the Vault server and its AWS auth method - IAM type

# Policy document (only in TF) that gives needed EC2 permissions for Raft auto_join feature
data "aws_iam_policy_document" "vault_aws_auth" {
  statement {
    sid       = "vaultPolicyDocumentVaultAWSAuth"
    effect    = "Allow"
    resources = ["*"]

    actions = [
        "ec2:DescribeInstances",
        "iam:GetInstanceProfile",
        "iam:GetUser",
        "iam:GetRole"
    ]
  }
}

# Creating a managed policy for KMS auto unseal feature
resource "aws_iam_policy" "vault_aws_auth_policy" {
  name        = "vault-policy-vault-aws-auth-${var.region}-${var.random_id}"
  path        = "/"
  description = "Policy that provides the needed permissions for the Vault server to verify users via the AWS authentication method (iam type)"

  policy = data.aws_iam_policy_document.vault_aws_auth.json
}
