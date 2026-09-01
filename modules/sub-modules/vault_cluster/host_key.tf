# Generate RSA and EC keys for hostkeys
resource "tls_private_key" "host" {
  count       = length(local.algorithms)
  algorithm   = local.algorithms[count.index]
  ecdsa_curve = local.algorithms[count.index] == "ECDSA" ? "P384" : "P224"
  rsa_bits    = local.algorithms[count.index] == "RSA" ? 4096 : 2048
}

# Auto adding to local known_hosts.
# ssh-keygen -R removes any existing entry for the IP first to prevent duplicates
# on re-apply. The destroy-time provisioner cleans up the entry when the instance
# is torn down.
resource "null_resource" "add_to_known_hosts" {
  for_each = local.availability_zones_sliced

  # triggers stores the public IP so the destroy-time provisioner can reference
  # it via self.triggers — destroy provisioners cannot access resource attributes
  # directly, only values captured in triggers at creation time.
  triggers = {
    public_ip = aws_instance.vault[each.key].public_ip
  }

  # Remove any stale entry for this IP first (2>/dev/null suppresses the harmless
  # "not found" warning on first apply), then append the current host key.
  provisioner "local-exec" {
    command = "ssh-keygen -R '${aws_instance.vault[each.key].public_ip}' 2>/dev/null; echo '${aws_instance.vault[each.key].public_ip} ${chomp(tls_private_key.host[1].public_key_openssh)}' >> ~/.ssh/known_hosts"
  }

  # Clean up the known_hosts entry when the instance is destroyed.
  # `true` ensures the provisioner never fails if the entry is already gone.
  provisioner "local-exec" {
    when    = destroy
    command = "ssh-keygen -R '${self.triggers.public_ip}' 2>/dev/null; true"
  }
}