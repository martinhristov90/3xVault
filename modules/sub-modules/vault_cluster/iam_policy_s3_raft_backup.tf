# This file creates a managed policy that allows the usage of S3 for storage of Raft storage backend snapshots

# Policy document (only in TF) that gives needed S3 permissions to store Raft snapshot in S3 bucket
data "aws_iam_policy_document" "vault_s3_snapshot_bucket" {
  statement {
    sid       = "vaultPolicyDocumentS3snapshot"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "s3:PutObject",
      "s3:ListBucket",
      "s3:DeleteObject"
    ]
  }
}

# Creating a managed policy for S3 Raft snapshot
resource "aws_iam_policy" "vault_s3_raft_snapshot_policy" {
  name        = "vault-policy-s3-raft-snapshot-policy-${var.region}-${var.random_id}"
  path        = "/"
  description = "Policy that provides the needed permissions to access S3 bucket in order to store Raft snapsahot"

  policy = data.aws_iam_policy_document.vault_s3_snapshot_bucket.json
}
