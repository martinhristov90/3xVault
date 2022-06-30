# Generate RSA and EC keys for hostkeys
resource "tls_private_key" "host" {
  count       = length(local.algorithms)
  algorithm   = local.algorithms[count.index]
  ecdsa_curve = local.algorithms[count.index] == "ECDSA" ? "P384" : "P224"
  rsa_bits    = local.algorithms[count.index] == "RSA" ? 4096 : 2048
}

# Auto adding to local known_hosts
resource "null_resource" "add_to_known_hosts" {
  for_each = local.availability_zones_sliced

  provisioner "local-exec" {
    command = "echo '${aws_instance.vault[each.key].public_ip} ${chomp(tls_private_key.host[1].public_key_openssh)}' >> ~/.ssh/known_hosts"
  }
}