Module: AWS/VPC Peering Connection
==================================

A Terraform module for creating the Peering Connection between two VPC's.

Module Input Variables
----------------------
- `accepter` - A configuration block that describes VPC Peering Connection options set for the accepter VPC.
- `requester` - A configuration block that describes VPC Peering Connection options set for the requester VPC.


Usage
-----

```hcl
module "vpc_peering" {
  source = "github.com/kvootla/Terraform-Groundwork//tf-aws-vpc-peering"

  requester_id = "${var.requester_id}"
  accepter_id  = "${var.accepter_id}"

  environment  = "prod"
  organization = "mhc"
}
```

Outputs
=======

- `id` - The ID of the specific VPC Peering Connection
