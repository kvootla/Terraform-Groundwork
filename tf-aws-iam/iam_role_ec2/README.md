Module: AWS/IAM Role for EC2 Instance
=====================================

A Terraform module for creating an IAM Role for EC2 Instance.

Module Input Variables
----------------------
- `name` - The profile's name. If omitted, Terraform will assign a random, unique name.
- `path` - (default "/") Path in which to create the profile.
- `role` - The role name to include in the profile.
- `policy_arn` - The ARN of the policy you want to apply.

Usage
-----

```hcl
module "ec2-iam-role" {
  source = "github.com/kvootla/Terraform-Groundwork//tf-aws-iam/iam_role_ec2"
  name   = "${var.name}"

  policy_arn = [
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess",
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy", 
 ]
}
```
Outputs
=======

- `arn` - The ARN assigned by AWS to the instance profile
- `name` - The instance profile's name
- `unique_id` - The unique ID assigned by AWS
