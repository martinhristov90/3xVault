# This file creates a managed policy that gives the needed permissions for Raft auto join feature

# Policy document (only in TF) that gives needed EC2 permissions for Raft auto_join feature
data "aws_iam_policy_document" "raft_auto_join" {
  statement {
    sid       = "vaultPolicyDocumentRaftAutoJoin"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ec2:DescribeInstances",
    ]
  }
}

# Creating a managed policy for KMS auto unseal feature
resource "aws_iam_policy" "vault_raft_auto_join_policy" {
  name        = "vault-policy-raft-auto-join-${var.region}-${var.random_id}"
  path        = "/"
  description = "Policy that provides the needed EC2 DescribeInstances permissions in order for the Raft auto join feature to work in AWS environment"

  policy = data.aws_iam_policy_document.raft_auto_join.json
}
