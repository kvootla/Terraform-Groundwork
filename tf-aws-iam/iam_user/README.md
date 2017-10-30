Module: AWS/IAM User
====================

A Terraform module for creating an IAM User.

Module Input Variables
----------------------
- `name` - The profile's name. If omitted, Terraform will assign a random, unique name.
- `path` - (default "/") Path in which to create the profile.

Usage
-----

```hcl
module "aws_iam_user" {
  source = "github.com/kvootla/Terraform-Groundwork//tf-aws-iam/iam_user"
  
  name          = "${var.name}"
  path          = "${var.path}"
  force_destroy = "${var.force_destroy}"
}
```

Outputs
=======

- `arn` - The ARN assigned by AWS to the instance profile
- `name` - The instance profile's name
- `unique_id` - The unique ID assigned by AWS
