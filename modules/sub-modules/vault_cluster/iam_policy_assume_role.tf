# This file create a policy document which allows the EC2 to assume the newly created role

# Policy document (only in TF) that allows EC2 service to assume the role
data "aws_iam_policy_document" "assume_role_vault_ec2" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]


    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
