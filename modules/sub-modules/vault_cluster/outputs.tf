output "vault_instance_public_ips" {
  value       = aws_instance.vault
  description = "Map of Vault EC2 instances keyed by availability zone"
}