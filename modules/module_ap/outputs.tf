output "vault_instance_public_ips" {
  value       = module.vault_cluster_ap.vault_instance_public_ips
  description = "Public IPs of the AP Vault cluster instances"
}