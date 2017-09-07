Module: AWS/Security Groups/Jenkins
================================

A terraform module with contains rules for a common jenkins application deployment, which


/**
you can use with your service Terraform template.

Ports
-----
- TCP 8080 (HTTP)
- TCP 443 (HTTPS)


Module Input Variables
----------------------

- `security_group_name` - The name for your security group, e.g. `bluffdale_jenkins_stage1`
- `vpc_id`              - The VPC this security group should be created in.

Usage
-----

```hcl
module "sg" {
  source              = "github.com/dchbx/infrastructure_modules/aws/sg/jenkins"
  security_group_name = "${var.security_group_name}"
  vpc_id            = "${var.vpc_id}"
  source_cidr_block   = "${var.source_cidr_block}"
}
```

Outputs
-------

- `security_group_id` - Jenkins SG ID
