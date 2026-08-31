output "vault_instance_public_ips" {
  value       = module.vault_cluster_us.vault_instance_public_ips
  description = "Public IPs of the US Vault cluster instances"
}