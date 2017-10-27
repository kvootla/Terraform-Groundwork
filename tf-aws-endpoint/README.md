Module: AWS/VPC Endpoint
========================

A Terraform module for making the Endpoint data source provides details about a specific VPC endpoint.

Module Input Variables
----------------------
- `vpc_id`       -  The ID of the VPC in which the specific VPC Endpoint is used.
- `service_name` - The AWS service name of the specific VPC Endpoint to retrieve.
- `route_table_ids` - One or more route tables associated with the VPC Endpoint.

Usage
-----

```hcl
module "ec2_instance" {
  source          = "github.com/kvootla/Terraform-Groundwork//tf-aws-endpoint"

  vpc_id          = "${var.vpc_id}"
  service_name    = "${var.service_name}"
  route_table_ids = ["${var.route_table_ids}"]
}
```

Outputs
=======

- `endpoint_id` - ID of the specific VPC Endpoint to retrieve
