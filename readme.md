## Simple PoC project that creates three Vault clusters in three different AWS regions.

-----

![Vault Logo](https://github.com/hashicorp/vault/raw/f22d202cde2018f9455dec755118a9b84586e082/Vault_PrimaryLogo_Black.png)


### What is it : 

  This project creates three node Vault environment joined in a Raft (integrated storage) cluster in three different AWS regions.

### Simple diagram :

![Diagram](https://app.lucidchart.com/publicSegments/view/27a3bfca-9460-4c74-b7a2-2e9f209dc350/image.png)

### Prerequisites :

  - Having AWS account with the necessary permissions.
  - Terraform v0.13.2 or higher

### Usage :

  - Clone the repository : `git clone https://github.com/martinhristov90/3xVault.git`.
  - Change into its directory : `cd 3xVault`.
  - Create `terraform.tfvars` file, example of how it should look like can be found below.
  - Put your Vault enterprise license in a file named `license_vault.txt`.
  - Initialize Terraform providers : `terraform init`.
  - Execute Terraform plan and apply: `terraform plan` and `terraform apply`.

### How to enable Vault replication :



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
  - [ ] Provide replication instructions
  - [ ] Output IPs of the nodes
  - [ ] Create LB
  - [ ] Isolate the instances and provide Bastion host for accessing them
  - [x] Create configuration object (custom object) for top-level `main.tf`
  - [ ] Add public DNS to the host keys of the local TF machine
  - [ ] Readme should include instructions on the licensing
  - [ ] Review the raft protocol configuration when new version of Vault comes out
  - [x] Do smarter check when licensing
  - [x] Improve VPC peering - Add routes to the existing route tables and adjust timeouts   when destroying
  - [ ] Install TF and to some config with TF Vault provider
  - [ ] Create usage GIF with peek

### Example `terraform.tfvars` :

  ```
  clusters = {
    "us" = { region = "us-east-1", vpc_cidr = "192.168.0.0/24" },
    "ap" = { region = "ap-east-1", vpc_cidr = "192.168.100.0/24" },
    "eu" = { region = "eu-central-1", vpc_cidr = "192.168.200.0/24" }
  }
  ```


### Contributing :

  - Special thanks to G.Berchev (https://github.com/berchev) for testing and helping with   this project. 
  - PRs are welcome

### License :
  - [MIT](https://choosealicense.com/licenses/mit/)