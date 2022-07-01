output "current-env-id" {
  value       = random_pet.env.id
  description = "Outputs the random ID used for particular deployment of the environment, useful for enabling S3 snapshots"
}

output "vault-cluster-us-public-ips" {
  value       = [for node in module.vault-cluster-us.vault-instance-public-ips : format("Name: %s - IP: %s", node.tags.Name, node.public_ip)]
  description = "Prints public IPs for the nodes in the US cluster"
}

output "vault-cluster-eu-public-ips" {
  value       = [for node in module.vault-cluster-eu.vault-instance-public-ips : format("Name: %s - IP: %s", node.tags.Name, node.public_ip)]
  description = "Prints public IPs for the nodes in the EU cluster"
}

output "vault-cluster-ap-public-ips" {
  value       = [for node in module.vault-cluster-ap.vault-instance-public-ips : format("Name: %s - IP: %s", node.tags.Name, node.public_ip)]
  description = "Prints public IPs for the nodes in the AP cluster"
}