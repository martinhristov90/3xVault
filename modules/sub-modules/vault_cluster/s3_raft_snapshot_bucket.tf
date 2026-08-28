# Instructing TFSEC to ignore logging, might be enabled in the future
# tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "raft_snapshot_bucket" {
  bucket        = "raft-snapshot-bucket-${var.region}-${var.random_id}"
  force_destroy = true

  tags = {
    Name = "vault-${var.region}-${var.random_id}"
  }
}

resource "aws_s3_bucket_ownership_controls" "raft_snapshot_bucket" {
  bucket = aws_s3_bucket.raft_snapshot_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "raft_snapshot_bucket" {
  bucket = aws_s3_bucket.raft_snapshot_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.vault.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "raft_snapshot_bucket" {
  bucket = aws_s3_bucket.raft_snapshot_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "raft_snapshot_bucket" {
  bucket = aws_s3_bucket.raft_snapshot_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}