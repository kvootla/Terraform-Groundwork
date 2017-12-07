Module: AWS/Subnets
====================

A Terraform module to create public/private subnets with in the VPC.


Module Input Variables
----------------------

- `vpc_id` 	   - VPC id.
- `cidrs` 	   - List of VPC CIDR blocks.
- `organization`   - organization for whom the VPC will be used (lowercase abbreviations)
- `environment`    - environment, e.g. prod, preprod, etc. (optional - default: true)

Usage
-----

```hcl
module "subnet" {
  source = "github.com/dchbx/infrastructure_modules.git//aws/subnets"

  vpc_id       = "${var.vpc_id}"
  cidrs        = {"us-east-1a = "172.0.0.0/24"}

  organization = "dchbx"
  environment  = "dchbx"
}
```

Outputs
=======

- `subnet_ids` - Lst of subnet ids
- `route_table_ids` - List of route table ids
