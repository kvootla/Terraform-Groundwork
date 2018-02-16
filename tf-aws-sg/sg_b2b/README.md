
Module: AWS/Security Groups/B2B
===============================

A terraform module with contains rules for a common web application deployment, which 
you can use with your service Terraform template.

Ports
-----
- TCP 8001 (B2B)
- TCP 7001 (B2B)


Module Input Variables
----------------------

- `security_group_name` - The name for your security group`
- `vpc_id`              - The VPC this security group should be created
- `organization`        - organization for whom the VPC will be used (lowercase abbreviations)
- `environment`         - environment, e.g. prod, preprod, etc. (optional - default: true)

Usage
-----

```hcl
module "sg" {
  source              = "github.com/kvootla/Terraform-Groundwork//tf-aws-sg/sg_b2b"
  security_group_name = "${var.security_group_name}"
  vpc_id 	      = "${var.vpc_id}"
  source_cidr_block   = "${var.source_cidr_block}"
}
```

Outputs
-------

- `sg_id` - RDP SG ID
