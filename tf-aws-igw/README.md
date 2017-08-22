Module: AWS/Internet Gteway
===========================

A Terraform module to creating an Internet Gateway within VPC.


Module Input Variables
----------------------

- `vpc_id` - vpc id
- `name` - name (optional)
- `tags` - dictionary of tags that will be added to resources created by the module

Usage
-----

```hcl
module "igw" {
  source               = "github.com/kvootla/Terraform-Groundwork//tf-aws-igw"

  name   = "${var.name}"
  vpc_id = "${var.vpc_id}"

  tags {
    "Terraform" = "true"
    "Environment" = "${var.environment}"
  }
}
```

Outputs
=======
 
 - `igw_id` - igw id

