Module: AWS/Subnets/Public Subnet
=================================

A Terraform module to create public subnets in VPC in AWS.


Module Input Variables
----------------------

- `vpc_id` - VPC id
- `igw_id` - Internet gateway id
- `cidrs` - List of VPC CIDR blocks
- `map_public_ip_on_launch` - Should be true or false (optional, default is true)
- `organization`   - organization for whom the VPC will be used (lowercase abbreviations)
- `environment`    - environment, e.g. prod, preprod, etc. (optional - default: true)


Usage
-----

```hcl
module "public_subnet" {
  source = "github.com/dchbx/infrastructure_modules//aws/subnets/public_subnet"

  vpc_id = "vpc-12345678"
  cidrs  = {"us-east-1a = "10.2.1.0/24"}
  igw_id = "igw-12345678"

  organization       = "dchbx"
  environment        = "dchbx"
}
```

Outputs
=======

- `subnet_ids` - List of subnet ids
- `route_table_ids` - List of route table ids

