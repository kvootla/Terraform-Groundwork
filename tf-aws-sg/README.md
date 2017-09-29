Module: AWS/Security Groups
===========================

A terraform module with contains rules for a common web application deployment, which you can use with your service Terraform template.

Security Group Catalog
----------------------

This module contains the following security group templates for you to use as modules in service Terraform templates.

- [b2b] - this is a security group for graylog applications
    - It allows incoming TCP 8001, TCP 7001

- [chef] - this is a security group for graylog applications
    - It allows incoming TCP 22, TCP 443

- [global] - this is a security group for mongodb applications
    - It allows incoming TCP 0000

- [graylog] - this is a security group for ntp applications
    - It allows incoming TCP 12900, TCP 9000

- [jenkins] - this is a security group for oracle applications
    - It allows incoming TCP 8080, TCP 443

- [mongodb] - this is a security group for rabbitmq applications
    - It allows incoming TCP 27017

- [ntp] - this is a security group for ssh applications
    - It allows incoming UDP 123

- [oracle] - this is a security group for web applications
    - It allows incoming TCP 1521

- [rabbitmq] - this is a security group for ntp applications
    - It allows incoming TCP 5671, TCP 5672, TCP 15671, TCP 15672

- [rdp] - this is a security group for oracle applications
    - It allows incoming TCP 3389

- [redis] - this is a security group for rabbitmq applications
    - It allows incoming TCP 6379

- [ssh] - this is a security group for ssh applications
    - It allows incoming TCP 22

- [web] - this is a security group for web applications
    - It allows incoming TCP 80, TCP 443


Module Input Variables
----------------------

- `security_group_name` - The name for your security group, e.g. `bluffdale_web_stage1`
- `vpc_id`              - The VPC this security group should be created in.

Usage
-----

```hcl
module "sg" {
  source              = "github.com/kvootla/Terraform-Groundwork//tf-aws-sg/sg_xxxxxx"
  security_group_name = "${var.security_group_name}"
  vpc_id  	      = "${var.vpc_id}"
  source_cidr_block   = "${var.source_cidr_block}"
}
```

Outputs
-------

- `security_group_id` - SG ID
