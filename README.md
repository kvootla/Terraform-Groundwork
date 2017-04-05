Module: AWS/Security Groups
===========================

A terraform module with contains rules for a common web application deployment, which 
you can use with your service Terraform template.

Ports
-----
- TCP 22 (SSH)
- TCP 80 (HTTP)
- TCP 443 (HTTPS)
- TCP 1099 (JMX)
- TCP 8080 (HTTP/S)

Module Input Variables
----------------------

- `security_group_name` - The name for your security group, e.g. `bluffdale_web_stage1`
- `vpc_id` - The VPC this security group should be created in.

Usage
-----

You can use these in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. `main.tf`

```
module "sg" {
  source = "github.com/dchbx/infrastructure_modules//aws/sg"
  security_group_name = "${var.security_group_name}"
  vpc_id = "${var.vpc_id}"
  source_cidr_block = "${var.source_cidr_block}"
}
```

2. Setting values for the following variables, either through `terraform.tfvars` or `-var` arguments on the CLI

- security_group_name
- vpc_id
- source_cidr_block

Outputs
-------
security_group_id - SG ID
