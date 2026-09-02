# This file creates a managed policy that gives the needed permissions for Raft auto join feature

# Policy document (only in TF) that gives needed EC2 permissions for Raft auto_join feature
data "aws_iam_policy_document" "raft_auto_join" {
  statement {
    sid    = "vaultPolicyDocumentRaftAutoJoin"
    effect = "Allow"

    # ec2:DescribeInstances is a list-level action — AWS does not support
    # resource-level restrictions for it, so "*" is required here.
    # See: https://docs.aws.amazon.com/service-authorization/latest/reference/list_amazonec2.html
    resources = ["*"]

    actions = [
      "ec2:DescribeInstances",
    ]

    # Scope to the current AWS account to prevent cross-account enumeration.
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values   = [var.region]
    }
  }
}

# Creating a managed policy for Raft auto join feature
resource "aws_iam_policy" "vault_raft_auto_join_policy" {
  name        = "vault-policy-raft-auto-join-${var.region}-${var.random_id}"
  path        = "/"
  description = "Policy that provides the needed EC2 DescribeInstances permissions in order for the Raft auto join feature to work in AWS environment"

  policy = data.aws_iam_policy_document.raft_auto_join.json
}
