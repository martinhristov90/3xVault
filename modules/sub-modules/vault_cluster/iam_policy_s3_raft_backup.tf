# This file creates a managed policy that allows the usage of S3 for storage of Raft storage backend snapshots

# Policy document (only in TF) that gives needed S3 permissions to store Raft snapshot in S3 bucket
data "aws_iam_policy_document" "vault_s3_snapshot_bucket" {
  # s3:ListBucket is a bucket-level action — resource must be the bucket ARN.
  statement {
    sid       = "vaultPolicyDocumentS3snapshotBucket"
    effect    = "Allow"
    resources = [aws_s3_bucket.raft_snapshot_bucket.arn]

    actions = [
      "s3:ListBucket",
    ]
  }

  # Object-level actions require the objects ARN (bucket-arn/*), not the bucket ARN.
  # s3:GetObject is required for snapshot restore in addition to backup.
  #tfsec:ignore:aws-iam-no-policy-wildcards
  statement {
    sid       = "vaultPolicyDocumentS3snapshotObjects"
    effect    = "Allow"
    resources = ["${aws_s3_bucket.raft_snapshot_bucket.arn}/*"]

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
    ]
  }
}

# Creating a managed policy for S3 Raft snapshot
resource "aws_iam_policy" "vault_s3_raft_snapshot_policy" {
  name        = "vault-policy-s3-raft-snapshot-policy-${var.region}-${var.random_id}"
  path        = "/"
  description = "Policy that provides the needed permissions to access S3 bucket in order to store and restore Raft snapshots"

  policy = data.aws_iam_policy_document.vault_s3_snapshot_bucket.json
}
