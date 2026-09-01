<!-- BEGIN_TF_DOCS -->


## Usage

```hcl
# Creating HQ cluster in US
module "vault_cluster_us" {

  source = "./modules/sub-modules/vault_cluster"

  vault_common_ca_cert        = local.vault_common_ca_cert
  vault_common_ca_private_key = local.vault_common_ca_private_key
  random_id                   = local.random_id
  vault_license               = local.vault_license

  region            = var.clusters.us.region
  vpc_cidr          = var.clusters.us.vpc_cidr
  vault_version     = var.clusters.us.vault_version
  vault_ec2_type    = var.clusters.us.vault_ec2_type
  use_private_image = var.clusters.us.use_private_image

  providers = {
    aws = aws.us-provider
  }
}

# Creating DR cluster in Europe
module "vault_cluster_eu" {

  source = "./modules/sub-modules/vault_cluster"

  vault_common_ca_cert        = local.vault_common_ca_cert
  vault_common_ca_private_key = local.vault_common_ca_private_key
  random_id                   = local.random_id
  vault_license               = local.vault_license

  region            = var.clusters.eu.region
  vpc_cidr          = var.clusters.eu.vpc_cidr
  vault_version     = var.clusters.eu.vault_version
  vault_ec2_type    = var.clusters.eu.vault_ec2_type
  use_private_image = var.clusters.eu.use_private_image

  providers = {
    aws = aws.eu-provider
  }
}

# Creating PR cluster in Asia
module "vault_cluster_ap" {

  source = "./modules/sub-modules/vault_cluster"

  vault_common_ca_cert        = local.vault_common_ca_cert
  vault_common_ca_private_key = local.vault_common_ca_private_key
  random_id                   = local.random_id
  vault_license               = local.vault_license

  region            = var.clusters.ap.region
  vpc_cidr          = var.clusters.ap.vpc_cidr
  vault_version     = var.clusters.ap.vault_version
  vault_ec2_type    = var.clusters.ap.vault_ec2_type
  use_private_image = var.clusters.ap.use_private_image

  providers = {
    aws = aws.ap-provider
  }
}

# Connecting the clusters together, the DR and PR clusters have no connection.
module "inter_vpc_peering" {
  source = "./modules/sub-modules/vpc_peering"

  clusters  = var.clusters
  random_id = local.random_id

  # Workaround in order `depends_on` to work
  providers = {
    aws.hq_provider = aws.us-provider
    aws.dr_provider = aws.eu-provider
    aws.pr_provider = aws.ap-provider
  }

  depends_on = [module.vault_cluster_ap, module.vault_cluster_eu, module.vault_cluster_us]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.16.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.67.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.9.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.3.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.9.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | ~> 2.4.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 3.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.9.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_inter_vpc_peering"></a> [inter\_vpc\_peering](#module\_inter\_vpc\_peering) | ./modules/sub-modules/vpc_peering | n/a |
| <a name="module_vault_cluster_ap"></a> [vault\_cluster\_ap](#module\_vault\_cluster\_ap) | ./modules/sub-modules/vault_cluster | n/a |
| <a name="module_vault_cluster_eu"></a> [vault\_cluster\_eu](#module\_vault\_cluster\_eu) | ./modules/sub-modules/vault_cluster | n/a |
| <a name="module_vault_cluster_us"></a> [vault\_cluster\_us](#module\_vault\_cluster\_us) | ./modules/sub-modules/vault_cluster | n/a |
| <a name="module_vault_common_ca"></a> [vault\_common\_ca](#module\_vault\_common\_ca) | ./modules/sub-modules/common_vault_ca | n/a |

## Resources

| Name | Type |
|------|------|
| [random_pet.env](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clusters"></a> [clusters](#input\_clusters) | Defines all Vault clusters, map of custom objects | <pre>map(object({<br>    region            = string<br>    vpc_cidr          = string<br>    vault_version     = string<br>    vault_ec2_type    = string<br>    use_private_image = bool<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_current_env_id"></a> [current\_env\_id](#output\_current\_env\_id) | Outputs the random ID used for particular deployment of the environment, useful for enabling S3 snapshots |
| <a name="output_vault_cluster_ap_public_ips"></a> [vault\_cluster\_ap\_public\_ips](#output\_vault\_cluster\_ap\_public\_ips) | Prints public IPs for the nodes in the AP cluster |
| <a name="output_vault_cluster_eu_public_ips"></a> [vault\_cluster\_eu\_public\_ips](#output\_vault\_cluster\_eu\_public\_ips) | Prints public IPs for the nodes in the EU cluster |
| <a name="output_vault_cluster_us_public_ips"></a> [vault\_cluster\_us\_public\_ips](#output\_vault\_cluster\_us\_public\_ips) | Prints public IPs for the nodes in the US cluster |
| <a name="output_z_ssh_commands_ap"></a> [z\_ssh\_commands\_ap](#output\_z\_ssh\_commands\_ap) | Ready-to-run SSH commands for every node in the AP cluster |
| <a name="output_z_ssh_commands_eu"></a> [z\_ssh\_commands\_eu](#output\_z\_ssh\_commands\_eu) | Ready-to-run SSH commands for every node in the EU cluster |
| <a name="output_z_ssh_commands_us"></a> [z\_ssh\_commands\_us](#output\_z\_ssh\_commands\_us) | Ready-to-run SSH commands for every node in the US cluster |
<!-- END_TF_DOCS -->