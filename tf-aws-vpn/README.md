Module: AWS/VPN Gateway
=======================

A Terraform module is intended to deploy a VPN Gateway which is attached to a VPC, deploy a single AWS Customer Gateway and other resources necessary to configure a functioning VPN Connection.


Module Input Variables
----------------------

- `vpc_id` - VPC ID where vpn Gateway(s) will be attached
- `enable_vgw_route_propagation` - Whether the routes known to the Virtual Private Gateway, are propagated to the route tables listed in the route_table_ids listed. Accepts either true of false.
- `customer_gateway_id` - Customer Gateway ID
- `enable_dns_hostnames` - should be true if you want to use private DNS within the VPC (optional - default: true)
- `enable_dns_support`   - should be true if you want to use private DNS within the VPC (optional - default: true)
- `customer_gateway_id`  - should be true
- `vpn_gateway_id`       - Specify which VPN Gateway the Customer Gateway will be associated
- `bgp_asn`              - BGP ASN of the Customer Gateway. By convention, use 65000 if you are not running BGP
- `static_routes_only`   - Whether the VPN connection uses static routes exclusively. Static routes must be used for devices that don't support BGP.
- `organization`         - organization for whom the VPC will be used (lowercase abbreviations)
- `environment`          - environment, e.g. prod, preprod, etc. (optional - default: true

Usage
-----

```hcl
module "vpn" {
  source       = "github.com/kvootla/Terraform-Groundwork//tf-aws-vpn"

  vpc_id              = "${var.vpc_id}"
  vpn_gateway_id      = "${aws_vpn_gateway.main.id}"
  customer_gateway_id = "${var.customer_gateway_id}"
  type                = "ipsec.1"

  Organization        = "${var.organization}"
  Environment         = "${var.environment}"
}
```

Outputs
=======

 - `vgw_id` - ARN for the created VPN Gateway 
 - `cgw_id` - ARN for the created Customer Gateway.
 - `cgw_ip_address` - The IP address of the gateway's Internet-routable external interface.
 - `cgw_bgp_asn` - The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN).
