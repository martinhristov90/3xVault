# Creating SSH to connect to the Vault servers
# Just a key
resource "tls_private_key" "vault-ssh-key" {
  algorithm = "RSA"
}

resource "null_resource" "main" {
  # Triggers are dirty hack so i can use the `var.region` in `destroy` provisioner
  triggers = {
    region = var.region
  }

  provisioner "local-exec" {
    command = "echo \"${tls_private_key.vault-ssh-key.private_key_pem}\" > ${path.root}/private_keys/private-${var.region}.key"
  }

  # Saving it to the local dir, so to be able to connect to Vault server in AWS
  provisioner "local-exec" {
    command = "chmod 600 ${path.root}/private_keys/private-${var.region}.key"
  }

  # Deleting the private key at destroy time
  provisioner "local-exec" {
    when       = destroy
    command    = "rm ${path.root}/private_keys/private-${self.triggers.region}.key"
    on_failure = continue
  }
}

# Vault server's EC2s are dependent on this key
resource "aws_key_pair" "vault-ssh-key" {
  key_name   = "vault-${var.region}-${var.random_id}"
  public_key = tls_private_key.vault-ssh-key.public_key_openssh
}