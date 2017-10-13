Module: AWS/Customer Gateway
============================

A Terraform module for creating the customer gateway.

Module Input Variables
----------------------
- `bgp_asn` - (Required) The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN).
- `ip_address` - (Required) The IP address of the gateway's Internet-routable external interface.
- `type` - (Required) The type of customer gateway. The only type AWS supports at this time is "ipsec.1".
- `tags` - (Optional) Tags to apply to the gateway.

Usage
-----

```hcl
module "cgw" {
  source = "github.com/kvootla/Terraform-Groundwork//tf-aws-cgw"

  ip_address = ""${var.ip_address}"
  bgp_asn    = "65000"

  environment  = "test"
  organization = "mhc"
}
```

Outputs
=======

- `id` - The amazon-assigned ID of the gateway
- `bgp_asn` - The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN)
- `ip_address` - The IP address of the gateway's Internet-routable external interface
