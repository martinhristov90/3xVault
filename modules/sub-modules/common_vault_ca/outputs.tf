output "common_ca_private_key" {
  value       = tls_private_key.private_key_vault_ca.private_key_pem
  description = "Private key of CA in PEM"
}

output "vault_common_ca_cert" {
  value       = tls_self_signed_cert.ca_cert.cert_pem
  description = "CA cert in PEM"
}