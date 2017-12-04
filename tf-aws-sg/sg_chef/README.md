Module: AWS/Security Groups/Chef
================================

A terraform module with contains rules for a common web application deployment, which you can use with your service Terraform template.

Ports
-----
- TCP 22 (SSH)
- TCP 443 (HTTPS)

Module Input Variables
----------------------

- `security_group_name` - The name for your security group, e.g. `bluffdale_web_stage1`
- `vpc_id`              - The VPC this security group should be created in.

Usage
-----

```hcl
module "sg" {
  source              = "github.com/kvootla/Terraform-Groundwork//tf-aws-sg/sg_chef"
  security_group_name = "${var.security_group_name}"
  vpc_id  	      = "${var.vpc_id}"
  source_cidr_block   = "${var.source_cidr_block}"
}
```

Outputs
-------

- `sg_id` - SG ID
