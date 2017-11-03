Module: AWS/Routes - VGW Gateway
================================

A Terraform module for creating VGW Gateway looping into Route tables.

Module Input Variables
----------------------
- `route_table_id` - (Optional) The id of the specific Route Table to retrieve.
- `cidr_block` - The CIDR block of the route.
- `vgw_id` - VGW gateway id.

Usage
-----

```hcl
module "aws_routes" {
  source    = "github.com/kvootla/Terraform-Groundwork//tf-aws-routes/vgw"
  
  route_table_id         = "${var.route_table_id}"
  destination_cidr_block = "${var.cidr_block}"
  vgw_gateway_id         = "${var.vgw_id}"
}
```
