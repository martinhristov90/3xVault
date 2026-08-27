
# Here the actual KMS symetric key is created.
resource "aws_kms_key" "vault" {
  description             = "Vault unseal key ${var.region}"
  deletion_window_in_days = 20 # Delete in 20 days
  enable_key_rotation     = true

  tags = {
    Name = "vault-kms-unseal-${var.region}-${var.random_id}" # All resources will be tagged this way
  }
}