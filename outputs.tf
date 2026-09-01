output "current_env_id" {
  value       = random_pet.env.id
  description = "Outputs the random ID used for particular deployment of the environment, useful for enabling S3 snapshots"
}

output "vault_cluster_us_public_ips" {
  value       = [for node in module.vault_cluster_us.vault_instance_public_ips : format("Name: %s - IP: %s", node.tags.Name, node.public_ip)]
  description = "Prints public IPs for the nodes in the US cluster"
}

output "vault_cluster_eu_public_ips" {
  value       = [for node in module.vault_cluster_eu.vault_instance_public_ips : format("Name: %s - IP: %s", node.tags.Name, node.public_ip)]
  description = "Prints public IPs for the nodes in the EU cluster"
}

output "vault_cluster_ap_public_ips" {
  value       = [for node in module.vault_cluster_ap.vault_instance_public_ips : format("Name: %s - IP: %s", node.tags.Name, node.public_ip)]
  description = "Prints public IPs for the nodes in the AP cluster"
}

# ---------------------------------------------------------------------------
# SSH convenience outputs — prefixed with "z_" so they sort after everything
# ---------------------------------------------------------------------------

output "z_ssh_commands_us" {
  value = [for node in module.vault_cluster_us.vault_instance_public_ips :
    format("ssh -i private_keys/private-%s.key ubuntu@%s  # %s",
    var.clusters.us.region, node.public_ip, node.tags.Name)
  ]
  description = "Ready-to-run SSH commands for every node in the US cluster"
}

output "z_ssh_commands_eu" {
  value = [for node in module.vault_cluster_eu.vault_instance_public_ips :
    format("ssh -i private_keys/private-%s.key ubuntu@%s  # %s",
    var.clusters.eu.region, node.public_ip, node.tags.Name)
  ]
  description = "Ready-to-run SSH commands for every node in the EU cluster"
}

output "z_ssh_commands_ap" {
  value = [for node in module.vault_cluster_ap.vault_instance_public_ips :
    format("ssh -i private_keys/private-%s.key ubuntu@%s  # %s",
    var.clusters.ap.region, node.public_ip, node.tags.Name)
  ]
  description = "Ready-to-run SSH commands for every node in the AP cluster"
}
