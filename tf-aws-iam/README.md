Module: AWS/IAM Resources
=========================

A Terraform module for creating an IAM Resources.

Module Input Variables
----------------------
- `name` - The profile's name. If omitted, Terraform will assign a random, unique name.
- `path` - (default "/") Path in which to create the profile.
- `role` - The role name to include in the profile.
- `policy_arn` - The ARN of the policy you want to apply.
- `force_destroy` -  When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed.

Usage
-----

```hcl
module "iam-resources" {
  source = "github.com/kvootla/Terraform-Groundwork//tf-aws-iam"
  name   = "${var.name}"
  path   = "${var.path}"

}
```
Outputs
=======

- `arn` - The ARN assigned by AWS to the instance profile
- `name` - The instance profile's name
- `unique_id` - The unique ID assigned by AWS
