Module: AWS/Data AMI 
====================

A Terraform module for data source to get the ID of a registered AMI for use in other resources.

Module Input Variables
----------------------
- `distribution` - Linux distribution for AWS AMI, supported: ecs, centos7, ubuntu1604, ubuntu1204.


Usage
-----

```hcl
resource "data_source" "main" {
    ecs        = "${data.aws_ami.ecs.id}"
    centos7    = "${data.aws_ami.centos7.id}"
    ubuntu1604 = "${data.aws_ami.ubuntu1604.id}"
    ubuntu1204 = "${data.aws_ami.ubuntu1204.id}"
}
```

Outputs
=======

- `ami_id` - AMI ID for Linux distribution
