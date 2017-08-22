Module: AWS/VPC DHCP
====================

A Terraform module to provide a VPC DHCP in AWS.


Module Input Variables
----------------------

- `vpc_id` - The VPC this dhcp should be created in.
- `domain_name` - suffix domain name to use by default when resolving non Fully Qualified Domain Names. (optional - default: true).
- `name_servers` - List of name servers to configure in /etc/resolv.conf.
- `netbios_name_servers` - List of NETBIOS name servers.
- `netbios_node_type` - The NetBIOS node type (1, 2, 4, or 8). AWS recommends to specify 2 since broadcast and multicast are not supported in their network.
- `ntp_servers` -  List of NTP servers to configure.
- `organization` - organization for whom the VPC will be used (lowercase abbreviations).
- `environment` - environment, e.g. prod, preprod, etc. (optional - default: true).

Usage
-----

```hcl
module "vpc_dhcp" {
  source               = "github.com/kvootla/Terraform-Groundwork//tf-aws-vpc-dhcp"

  domain_name = "dchbx.org"
  vpc_id       = "${var.vpc_id}"
 
  organization = "dchbx"
  environment  = "prod"
}
```

Outputs
=======

 - `dhcp_id` - VPC DHCP ID

