output "vault_instance_public_ips" {
  value       = module.vault_cluster_eu.vault_instance_public_ips
  description = "Public IPs of the EU Vault cluster instances"
}