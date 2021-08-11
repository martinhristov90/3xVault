# This file creates a managed policy for utilizing the Vault's AWS secrets engine


# Policy document (only in TF) that gives needed EC2 permissions for Raft auto_join feature
data "aws_iam_policy_document" "vault_aws_secret" {
  statement {
    sid       = "vaultPolicyDocumentVaultAWSSecret"
    effect    = "Allow"
    resources = ["arn:aws:iam::${data.aws_caller_identity.current_aws_account.id}:user/vault-*"]

    actions = [
      "iam:AttachUserPolicy",
      "iam:CreateAccessKey",
      "iam:CreateUser",
      "iam:DeleteAccessKey",
      "iam:DeleteUser",
      "iam:DeleteUserPolicy",
      "iam:DetachUserPolicy",
      "iam:ListAccessKeys",
      "iam:ListAttachedUserPolicies",
      "iam:ListGroupsForUser",
      "iam:ListUserPolicies",
      "iam:PutUserPolicy",
      "iam:AddUserToGroup",
      "iam:RemoveUserFromGroup"
    ]
  }
}

# Creating a managed policy for KMS auto unseal feature
resource "aws_iam_policy" "vault_aws_secret_policy" {
  name        = "vault-policy-vault-aws-secret-${var.region}-${var.random_id}"
  path        = "/"
  description = "Policy that provides the needed permissions for the Vault server's aws secrets engine to function properly"

  policy = data.aws_iam_policy_document.vault_aws_secret.json
}
