Module: AWS/Routes - NAT Gateway
================================

A Terraform module for creating NAT Gateway looping into Route tables.

Module Input Variables
----------------------
- `route_table_id` - (Optional) The id of the specific Route Table to retrieve.
- `cidr_block` - The CIDR block of the route.
- `ngw_id` - Nat gateway id.

Usage
-----

```hcl
module "aws_routes" {
  source    = "github.com/kvootla/Terraform-Groundwork//tf-aws-routes/ngw"
  
  route_table_id         = "${var.route_table_id}"
  destination_cidr_block = "${var.cidr_block}"
  nat_gateway_id         = "${var.ngw_id}"
}
```
