Module: AWS/Internet Gateway
============================

A Terraform module to creating an Internet Gateway within VPC.


Module Input Variables
----------------------

- `vpc_id`       - vpc id
- `organization` - organization for whom the VPC will be used (lowercase abbreviations)
- `environment`  - environment, e.g. prod, preprod, etc. (optional - default: true

Usage
-----

```hcl
module "igw" {
  source = "github.com/kvootla/Terraform-Groundwork//tf-aws-igw"

  name         = "${var.name}"
  vpc_id       = "${var.vpc_id}"
  organization = "dchbx"
  environment  = "prod"
}
```

Outputs
=======
 
 - `igw_id` - igw id

