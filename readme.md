## Simple PoC project that creates three Vault clusters in three different AWS regions.

### TODO :

- [x] Install host keys
- [x] Use cloud-init to setup Hashicorp DEB repo 
- [x] Install Vault from the DEB repo
- [x] Implement TLS for Vault
- [x] Provision Vault
- [x] Add Vault Ent license
- [x] Create Raft storage
- [x] Use cloud-init for exchanging CAs
- [ ] Setup replication
- [x] Create role for instance profile of EC2
- [ ] Utilize the instance profile for KMS and AWS auth
- [x] Fix SystemD issue - Vault does not start
- [ ] Output IPs of the nodes
- [ ] Create LB
- [ ] Isolate the instances and provide Bastion host for accessing them
- [ ] Create configuration object (custom object) for top-level `main.tf`
- [ ] Add public DNS to the host keys of the local TF machine


### Thanks :

- Special thanks to G.Berchev (https://github.com/berchev) for testing and helping with this project. 