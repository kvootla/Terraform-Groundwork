Module: AWS/Routes - NAT Gateway
================================

A Terraform module for creating NAT Gateway looping into Route tables.

Module Input Variables
----------------------
- `vpc_id` - The id of the VPC that the desired Route Table belongs to.
- `subnet_id` - The id of a Subnet which is connected to the Route Table (not be exported if not given in parameter).
- `igw_id` - Internet gateway ID

Usage
-----

```hcl
module "route_igw" {
  source      = "github.com/kvootla/Terraform-Groundwork//tf-aws-routes/route_nat"
  vpc_id      = "${var.vpc_id}"
  subnet_id   = "${var.subnet_id}"
  nat_id      = "${var.nat_id}"

  Organization = "${var.organization}"
  Environment  = "${var.environment}"
}
```

Outputs
=======

- `route_table_id` - The id of the specific Route Table to retrieve.
