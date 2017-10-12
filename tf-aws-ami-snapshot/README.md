Module: AWS/AMI from Instance
=============================

A Terraform module for taking the sanpshot an AMI from Instance.

Module Input Variables
----------------------
- `name` - (Required) A region-unique name for the AMI.
- `source_instance_id` - (Required) The id of the instance to use as the basis of the AMI.

Usage
-----

```hcl
module "ami_snapshot" {
  source = "github.com/kvootla/Terraform-Groundwork//tf-aws-snapshot"

  source_instance_id = "${var.source_instance_id}"
  environment        = "test"
  organization       = "mhc"
  application        = "enroll"
}

```
Outputs
=======

- `id` - The ID of the created AMI
