Module: AWS/Security Groups/Rabbitmq
====================================

A terraform module with contains rules for a common web application deployment, which you can use with your service Terraform template.

Ports
-----
- TCP 5671
- TCP 5672
- TCP 15671
- TCP 15672

Module Input Variables
----------------------

- `security_group_name` - The name for your security group
- `vpc_id` 		- The VPC this security group should be created
- `organization`        - organization for whom the VPC will be used (lowercase abbreviations)
- `environment`         - environment, e.g. prod, preprod, etc. (optional - default: true)

Usage
-----

```hcl
module "sg" {
  source	      = "github.com/kvootla/Terraform-Groundwork//tf-aws-sg/sg_rabbitmq"
  security_group_name = "${var.security_group_name}"
  vpc_id 	      = "${var.vpc_id}"
  source_cidr_block   = "${var.source_cidr_block}"
}
```

Outputs
-------

security_group_id - SG ID
