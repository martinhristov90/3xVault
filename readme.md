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
- [x] Fix SystemD issue - Vault does not start
- [x] Create role for instance profile of EC2
- [x] Utilize the instance profile for KMS
- [ ] Utilize the instance profile for AWS auth
- [ ] Setup replication
- [ ] Output IPs of the nodes
- [ ] Create LB
- [ ] Isolate the instances and provide Bastion host for accessing them
- [ ] Create configuration object (custom object) for top-level `main.tf`
- [ ] Add public DNS to the host keys of the local TF machine
- [ ] Readme should include instructions on the licensing
- [ ] Review the raft protocol configuration new version of Vault comes out


### Example `terraform.tfvars` :

```
clusters = {
  "us" = { region = "us-east-1", vpc_cidr = "192.168.0.0/24" },
  "ap" = { region = "ap-east-1", vpc_cidr = "192.168.100.0/24" },
  "eu" = { region = "eu-central-1", vpc_cidr = "192.168.200.0/24" }
}
```

### Thanks :

- Special thanks to G.Berchev (https://github.com/berchev) for testing and helping with this project. 