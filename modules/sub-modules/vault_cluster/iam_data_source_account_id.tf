# Getting the AWS account ID, it is used to create a policy and make sure that the AWS secrets engine has only permissions on IAM accounts that start with "vault-"
data "aws_caller_identity" "current_aws_account" {}
