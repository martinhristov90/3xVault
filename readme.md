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
  - Put your Vault enterprise license in a file named `license_vault.txt` in the root directory of this project.
  - Initialize Terraform providers : `terraform init`.
  - Execute Terraform plan and apply: `terraform plan` and `terraform apply`, the IPs of all Vault nodes are printed as Terraform outputs.
  - Each node located in `a1` AZ is the active node for the particular cluster. The `VAULT_TOKEN` env variable is automatically populated for the active node of each cluster.
### How to enable Vault replication :

- The directory `private_keys` in the root directory of this repository contains three private keys, each key is designated for particular region as its name suggests.
- Use the `private-us-east-1.key` key to connect to the `us-east-1` region (or other region that is configured by `terraform.tfvars`) : 

  ```
  ssh -i private_keys/private-us-east-1.key ubuntu@IP_ADDRESS_ACTIVE_NODE`
  ```

- Enable PR(ap-south-1 region) and DR(eu-central-1 region) replication in primary mode (the Vault token is pre-configured) :

  ```
  vault write -f sys/replication/performance/primary/enable 
  vault write -f sys/replication/dr/primary/enable
  ```

- Generate secondary tokens for PR(ap-south-1 region) and DR(eu-central-1 region) replications :

    * For PR(ap-south-1 region) :
      ```
      vault write -format=json sys/replication/performance/primary/secondary-token id=pr_secondary_asia | jq -r .wrap_info.token      
      ```
      
      The output should look like :  
      ```
      eyJhbGciOiJFUzUxMiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3NvciI6IiIsImFkZHIiOiJodHRwczovLzE5Mi4xNjguMC41OjgyMDAiLCJleHAiOjE2MDMxMTYyNjAsImlhdCI6MTYwMzExNDQ2MCwianRpIjoicy55OWtXUHRZTVJtMU9lczRQaEdjcnk4MkIiLCJuYmYiOjE2MDMxMTQ0NTUsInR5cGUiOiJ3cmFwcGluZyJ9.ANmspVajd3a3acxxxKSwjQNsTxms4zlM4Acbc-4F0Qh3T0ofoEwVu7KFN68OTJ2OxDAQ7d4LI_LOQbV1oG2Y8alBAWrGWyv3OPUQftA0h5yrTzer4ZLVqIwdik9cjzooJhkKtsQibWGioY48vxiaVpDIQWxGzwoCvFM2tOi8FD91BNYu
      ```

    * For DR(eu-central-1 region) :
      ```
      vault write -format=json sys/replication/dr/primary/secondary-token id=dr_secondary_europe | jq -r .wrap_info.token
      ```
      
      The output should look like :
      ```
      eyJhbGciOiJFUzUxMiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3NvciI6IiIsImFkZHIiOiJodHRwczovLzE5Mi4xNjguMC41OjgyMDAiLCJleHAiOjE2MDMxMTYyMjUsImlhdCI6MTYwMzExNDQyNSwianRpIjoicy5QWW55WmxoUnBONDlRMk5oaTB2RWQwVUciLCJuYmYiOjE2MDMxMTQ0MjAsInR5cGUiOiJ3cmFwcGluZyJ9.APs-iC01TgceBg9FGFaaZncK65b21j_xJMXWX8uXjlUj0QeiYEkT2n89HISbwSvc51yY7pYl8q2mkl1nF7u6-zXbAHvo_uLdYi3p2_LOynLN31hEFtdhgPgIECoSATBboe3OgdQ0yaWbpK7DoDcY4-k4b_Ueg_FU9nJMgzz1qsp0RWT3
      ```

      Take a note of the generated tokens, they are good for 30 minutes.

- Enable PR replication on the secondary side in `ap-south` region :

  * Login to the node with :
    ```
    ssh -i private_keys/private-ap-south-1.key ubuntu@IP_OF_AP_VAULT_NODE
    ```
  
  * Enable PR :
    ```
    vault write sys/replication/performance/secondary/enable token=eyJhbGciOiJFUzUxMiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3NvciI6IiIsImFkZHIiOiJodHRwczovLzE5Mi4xNjguMC41OjgyMDAiLCJleHAiOjE2MDMxMTYyNjAsImlhdCI6MTYwMzExNDQ2MCwianRpIjoicy55OWtXUHRZTVJtMU9lczRQaEdjcnk4MkIiLCJuYmYiOjE2MDMxMTQ0NTUsInR5cGUiOiJ3cmFwcGluZyJ9.ANmspVajd3a3acxxxKSwjQNsTxms4zlM4Acbc-4F0Qh3T0ofoEwVu7KFN68OTJ2OxDAQ7d4LI_LOQbV1oG2Y8alBAWrGWyv3OPUQftA0h5yrTzer4ZLVqIwdik9cjzooJhkKtsQibWGioY48vxiaVpDIQWxGzwoCvFM2tOi8FD91BNYu
    ```

  * Verify that the PR replication is in `stream-wals` state 
    ```
    vault read -format=json sys/replication/performance/status | jq -r .data.state
    ```

- Enable DR replication on the secondary side in `eu-central` region :

  * Login to the node with :
    ```
    ssh -i private_keys/private-eu-central-1.key ubuntu@IP_OF_EU_VAULT_NODE
    ```
  
  * Enable DR :
    ```
    vault write sys/replication/dr/secondary/enable token=eyJhbGciOiJFUzUxMiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3NvciI6IiIsImFkZHIiOiJodHRwczovLzE5Mi4xNjguMC41OjgyMDAiLCJleHAiOjE2MDMxMTYyMjUsImlhdCI6MTYwMzExNDQyNSwianRpIjoicy5QWW55WmxoUnBONDlRMk5oaTB2RWQwVUciLCJuYmYiOjE2MDMxMTQ0MjAsInR5cGUiOiJ3cmFwcGluZyJ9.APs-iC01TgceBg9FGFaaZncK65b21j_xJMXWX8uXjlUj0QeiYEkT2n89HISbwSvc51yY7pYl8q2mkl1nF7u6-zXbAHvo_uLdYi3p2_LOynLN31hEFtdhgPgIECoSATBboe3OgdQ0yaWbpK7DoDcY4-k4b_Ueg_FU9nJMgzz1qsp0RWT3
    ```

  * Verify that the DR replication is in `stream-wals` state :
    ```
    vault read -format=json sys/replication/dr/status | jq -r .data.state
    ```

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
  - [x] Utilize the instance profile for AWS auth
  - [x] Provide replication instructions
  - [x] Output IPs of the nodes
  - [ ] Create LB
  - [ ] Isolate the instances and provide Bastion host for accessing them
  - [x] Create configuration object (custom object) for top-level `main.tf`
  - [ ] Add public DNS to the host keys of the local TF machine
  - [x] Readme should include instructions on the licensing
  - [x] Review the raft protocol configuration when new version of Vault comes out
  - [x] Use cloud auto-join feature
  - [x] Do smarter check when licensing
  - [x] Improve VPC peering - Add routes to the existing route tables and adjust timeouts when destroying
  - [ ] Install TF and do some config with TF Vault provider. For example, enable `aws` auth, `aws` secrets engine and configure S3 Raft auto snapshot
  - [ ] Create usage GIF with peek
  - [x] Provide ability to enable Raft auto-snapshot feature
  - [x] Provide configurable Vault version for each cluster
  - [x] Add ability to select EC2 sizes.
### Example `terraform.tfvars` :

  ```
  clusters = {
  "us" = { region = "us-east-2", vpc_cidr = "192.168.0.0/24", vault_version = "1.10.3+ent-2", vault_ec2_type = "large" },
  "ap" = { region = "ap-south-1", vpc_cidr = "192.168.100.0/24", vault_version = "1.9.6+ent-2", vault_ec2_type = "large" },
  "eu" = { region = "eu-west-1", vpc_cidr = "192.168.200.0/24", vault_version = "1.9.6+ent-2", vault_ec2_type = "large" }
  }
  # For all versions of "vault-enterprise" package, run "apt list -a vault-enterprise" after installing the Hashicorp repo.
  # The "vault_ec2_type" variable should be one of the following types - small or large. Small corresponds to "t3.small" while "large" corresponds to "t3.large".
  ```

### Example of enabling S3 auto snapshot (backup) :

  ```
  vault write sys/storage/raft/snapshot-auto/config/vault_backup_bucket \
  storage_type="aws-s3" \
  aws_s3_bucket="raft-snapshot-bucket-<region-here>-<current-env-id>" \
  aws_s3_region="<region-here>" \
  interval="1m" \
  retain=5
  ```
  For every cluster there is a dedicated S3 bucket to keep the Raft snapshots. 
  Before using the above-mentioned command replace the `<region-here>` string with the region of the cluster, for example `us-east-2` and `<current-env-id>` string with the `current-env-id` TF output, for example `touched-cicada`, which corresponds to the current deployment.
  You can use the `terraform output` command to retrieve `current-env-id` value.

### Example SSH commands :

  ```
  ssh -i ./private_keys/private-ap-south-1.key ubuntu@IP_VAULT_INSTANCE_AP_REGION
  ssh -i ./private_keys/private-eu-west-1.key ubuntu@IP_VAULT_INSTANCE_EU_REGION
  ssh -i ./private_keys/private-us-east-2.key ubuntu@IP_VAULT_INSTANCE_US_REGION
  ```

### Contributing :

  - Special thanks to G.Berchev (https://github.com/berchev) for testing and helping with   this project. 
  - PRs are welcome !

### License :
  - [MIT](https://choosealicense.com/licenses/mit/)