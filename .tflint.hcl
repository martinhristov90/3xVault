# TFLint configuration for 3xVault
# https://github.com/terraform-linters/tflint

config {
  # Enable module inspection
  call_module_type = "all"

  # Force return an error if there are any issues
  force = false

  # Disable colored output
  disabled_by_default = false
}

# AWS Plugin Configuration
plugin "aws" {
  enabled = true
  version = "0.30.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"

  # Deep check for AWS resources (requires AWS credentials)
  deep_check = false
}

# Terraform Plugin Configuration
plugin "terraform" {
  enabled = true
  version = "0.5.0"
  source  = "github.com/terraform-linters/tflint-ruleset-terraform"

  preset = "recommended"
}

# General Terraform Rules
rule "terraform_deprecated_interpolation" {
  enabled = true
}

rule "terraform_deprecated_index" {
  enabled = true
}

rule "terraform_unused_declarations" {
  enabled = true
}

rule "terraform_comment_syntax" {
  enabled = true
}

rule "terraform_documented_outputs" {
  enabled = true
}

rule "terraform_documented_variables" {
  enabled = true
}

rule "terraform_typed_variables" {
  enabled = true
}

rule "terraform_module_pinned_source" {
  enabled = true
  style   = "semver"
}

rule "terraform_naming_convention" {
  enabled = true

  variable {
    format = "snake_case"
  }

  locals {
    format = "snake_case"
  }

  output {
    format = "snake_case"
  }

  resource {
    format = "snake_case"
  }

  module {
    format = "snake_case"
  }

  data {
    format = "snake_case"
  }
}

rule "terraform_required_version" {
  enabled = true
}

rule "terraform_required_providers" {
  enabled = true
}

rule "terraform_standard_module_structure" {
  enabled = true
}

rule "terraform_workspace_remote" {
  enabled = true
}

# AWS-Specific Security Rules
rule "aws_instance_invalid_type" {
  enabled = true
}

rule "aws_instance_previous_type" {
  enabled = true
}

rule "aws_db_instance_invalid_type" {
  enabled = true
}

rule "aws_db_instance_previous_type" {
  enabled = true
}

rule "aws_elasticache_cluster_invalid_type" {
  enabled = true
}

rule "aws_elasticache_cluster_previous_type" {
  enabled = true
}

# Security Group Rules
rule "aws_security_group_invalid_protocol" {
  enabled = true
}

# IAM Rules
rule "aws_iam_policy_document_gov_friendly_arns" {
  enabled = true
}

rule "aws_iam_role_policy_gov_friendly_arns" {
  enabled = true
}

# S3 Rules
rule "aws_s3_bucket_invalid_acl" {
  enabled = true
}

# Route53 Rules
rule "aws_route53_record_invalid_type" {
  enabled = true
}

# ELB Rules
rule "aws_elb_invalid_security_group" {
  enabled = true
}

rule "aws_elb_invalid_subnet" {
  enabled = true
}

rule "aws_alb_invalid_security_group" {
  enabled = true
}

rule "aws_alb_invalid_subnet" {
  enabled = true
}

# EC2 Rules
rule "aws_instance_invalid_ami" {
  enabled = true
}

rule "aws_instance_invalid_iam_profile" {
  enabled = true
}

rule "aws_launch_configuration_invalid_iam_profile" {
  enabled = true
}

rule "aws_launch_configuration_invalid_image_id" {
  enabled = true
}

# RDS Rules
rule "aws_db_instance_invalid_db_subnet_group" {
  enabled = true
}

rule "aws_db_instance_invalid_vpc_security_group" {
  enabled = true
}

# ElastiCache Rules
rule "aws_elasticache_cluster_invalid_parameter_group" {
  enabled = true
}

rule "aws_elasticache_cluster_invalid_security_group" {
  enabled = true
}

rule "aws_elasticache_cluster_invalid_subnet_group" {
  enabled = true
}

# CloudWatch Rules
rule "aws_cloudwatch_log_group_invalid_name" {
  enabled = true
}

# API Gateway Rules
rule "aws_api_gateway_model_invalid_name" {
  enabled = true
}

# Lambda Rules
rule "aws_lambda_function_invalid_runtime" {
  enabled = true
}
