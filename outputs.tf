output "current_env_id" {
  value       = random_pet.env.id
  description = "Outputs the random ID used for particular deployment of the environment, useful for enabling S3 snapshots"
}

output "vault_cluster_us_public_ips" {
  value       = [for node in module.vault_cluster_us.vault-instance-public-ips : format("Name: %s - IP: %s", node.tags.Name, node.public_ip)]
  description = "Prints public IPs for the nodes in the US cluster"
}

output "vault_cluster_eu_public_ips" {
  value       = [for node in module.vault_cluster_eu.vault-instance-public-ips : format("Name: %s - IP: %s", node.tags.Name, node.public_ip)]
  description = "Prints public IPs for the nodes in the EU cluster"
}

output "vault_cluster_ap_public_ips" {
  value       = [for node in module.vault_cluster_ap.vault-instance-public-ips : format("Name: %s - IP: %s", node.tags.Name, node.public_ip)]
  description = "Prints public IPs for the nodes in the AP cluster"
}
