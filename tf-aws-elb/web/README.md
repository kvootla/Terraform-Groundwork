Module: AWS/Elastic Load Balancer
=================================

A Terraform module for creating an ELB with just HTTP/HTTPS support


Module Input Variables
----------------------

- `name`                - The static name of the ELB
- `security_group_ids`  - The Security Group to associate with the ELB
- `internal`            - Defaults to `false`, you can set to `true` to make the ELB have an internal IP
- `subnet_ids`          - The VPC subnet ID for AZ1
- `instances`           - The list of instances which are attached to ELB.
- `instance_port`       - The port the service running on the EC2 insances will listen on
- `instance_protocol`   - The protocol the service on the backend_port understands, e.g. `http` 
- `target`              - The URL that the ELB should use for health

Usage
-----

```hcl
  module "my_web_elb" {
  source               = "github.com/kvootla/Terraform-Groundwork//tf-aws-elb"

  name                = "${var.name}"
  internal            = "{var.internal}"
  subnet_ids          = ["${var.subnet_ids}"]
  instances           = ["${var.instance_ids}"]
  security_group_ids  = ["${var.security_group_ids}"]
  instance_port       = "${var.backend_port}"
  instance_protocol   = "${var.backend_protocol}"
  target              = "${var.health_check_target}"
}
```

Outputs
=======

- `elb_id`       - ELB ID
- `elb_name`     - ELB Name
- `elb_dns_name` - ELB DNS Name
