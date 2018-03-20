Module: AWS/Subnets/Private Subnet
=================================

A Terraform module to create private subnets in VPC in AWS.


Module Input Variables
----------------------

- `vpc_id` - VPC id
- `igw_id` - Internet gateway id
- `cidrs` - List of VPC CIDR blocks
- `map_public_ip_on_launch` - Should be false (optional, default is true)
- `organization`   - organization for whom the VPC will be used (lowercase abbreviations)
- `environment`    - environment, e.g. prod, preprod, etc. (optional - default: true)


Usage
-----

```hcl
module "private_subnet" {
  source       = "github.com/kvootla/Terraform-Groundwork//tf-aws-subnets/private_subnet"
 
  vpc_id       = "${var.vpc_id}"
  cidrs        = "${var.cidrs}"
  subnet_id    = "${var.subnet_id}"
  Organization = "${var.organization}"
  Environment  = "${var.environment}"
}
```

Outputs
=======

- `subnet_ids` - List of subnet ids
- `route_table_ids` - List of route table ids

