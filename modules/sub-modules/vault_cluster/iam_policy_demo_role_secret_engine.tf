# This file creates a managed policy to be used by the Vault's AWS secrets engine (assume role cred)

# Policy document (only in TF) that gives permissions to use AWS auth method
data "aws_iam_policy_document" "vault_aws_secret_demo_role" {
  statement {
    sid       = "vaultPolicyDocumentVaultAWSSecretsDemoRole"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:DescribeInstances"
    ]
  }
}

# Creating a managed policy for AWS secret engine demo assumed role
resource "aws_iam_policy" "vault_aws_secret_demo_role_policy" {
  name        = "vault-secrets-engine-demouser-policy-${var.region}-${var.random_id}"
  path        = "/"
  description = "Policy used for demo user of AWS secrets engine assumed role type (iam type)"

  policy = data.aws_iam_policy_document.vault_aws_secret_demo_role.json

}
