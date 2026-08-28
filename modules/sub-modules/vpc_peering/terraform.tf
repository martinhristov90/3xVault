terraform {
  required_version = "~>1.16.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67.0"
      configuration_aliases = [
        aws.dr_provider,
        aws.hq_provider,
        aws.pr_provider,
      ]
    }
  }
}