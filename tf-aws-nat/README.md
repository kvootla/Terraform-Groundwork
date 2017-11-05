Module: AWS/NAT Gateway
======================

A Terraform module for creating NAT Gateway.

Module Input Variables
----------------------
- `allocation_id` - The Allocation ID of the Elastic IP address for the gateway.
- `subnet_id` - The Subnet ID of the subnet in which the NAT gateway is placed.
- `network_interface_id` - The ENI ID of the network interface created by the NAT gateway.

Usage
-----

```hcl
module "nat_gateway" {
  source    = "github.com/kvootla/Terraform-Groundwork//tf-aws-nat"
  
  subnet_id = "${var.subnet_id}"
  allocation_id = "${var.a;;ocation_id}"
}
```

Outputs
=======

- `allocation_id` - (Required) The Allocation ID of the Elastic IP address for the gateway
