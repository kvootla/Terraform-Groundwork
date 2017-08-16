Module: AWS/Subnets
====================

A Terraform module to create subnets in VPC in AWS.


Module Input Variables
----------------------

- `vpc_id` - VPC id
- `cidrs` - List of VPC CIDR blocks
- `organization`   - organization for whom the VPC will be used (lowercase abbreviations)
- `environment`    - environment, e.g. prod, preprod, etc. (optional - default: true)

Usage
-----

```hcl
module "subnet" {
  source = "github.com/dchbx/infrastructure_modules.git//aws/subnets"

  vpc_id = "vpc-12345678"
  cidrs  = {"us-east-1a = "10.2.1.0/24"}

  organization       = "dchbx"
  environment        = "dchbx"
}
```

Outputs
=======

- `subnet_ids` - Lst of subnet ids
- `route_table_ids` - List of route table ids

