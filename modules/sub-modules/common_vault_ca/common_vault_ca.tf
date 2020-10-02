# Generate private key for CA
resource "tls_private_key" "private_key_vault_ca" {
  algorithm = "RSA"
}

# Self-signing the CA 
resource "tls_self_signed_cert" "ca_cert" {
  key_algorithm   = "RSA" # Using RSA
  private_key_pem = tls_private_key.private_key_vault_ca.private_key_pem
  subject {
    common_name  = "Vault CA" # Modern browsers do not look at the CN, SANs are imporatant
    organization = "Vault CA"
  }

  validity_period_hours = 3600 # Validity in hours

  allowed_uses = [ # Needed permissions for signing Vault server certs.
    "crl_signing",
    "cert_signing"
  ]

  is_ca_certificate = true # It is CA
}

# Saving the CA cert to a file
resource "local_file" "ca" {
  content  = tls_self_signed_cert.ca_cert.cert_pem
  filename = "${path.module}/ca.pem"
}