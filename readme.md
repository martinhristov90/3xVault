## Simple PoC project that creates three Vault clusters in three different AWS regions.

### TODO :

- [x] Install host keys
- [x] Use cloud-init to setup Hashicorp DEB repo 
- [x] Install Vault from the DEB repo
- [ ] Implement TLS for Vault
- [ ] Provision Vault
- [ ] Add Vault Ent license
- [x] Create Raft storage
- [ ] Use cloud-init for exchanging CAs
- [ ] Setup replication
- [x] Create role for instance profile of EC2
- [ ] Utilize the instance profile for KMS and AWS auth
- [x] Fix SystemD issue - Vault does not start
- [ ] Output IPs of the nodes
- [ ] Create LB