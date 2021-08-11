resource "aws_s3_bucket" "raft_snapshot_bucket" {
  bucket = "raft-snapshot-bucket-${var.region}"
  acl    = "private"
  force_destroy = true
  
  tags = {
    Name = "vault-${var.region}-${var.random_id}"
  }
}