Module: AWS/EC2 Instance
========================

A Terraform module for making ec2 instances.


Module Input Variables
----------------------

- `ami_id`               - The AMI to use
- `number_of_instances`  - The number of instances you want made
- `subnet_id`            - The VPC subnet to place the instance in
- `instance_type`        - The EC2 instance type, e.g. m1.small
- `instance_name`        - The instance name you want, this is used to populate the Name tag
- `user_data`            - The path to the user_data file. Terraform will include the contents of this file while launching the instance
- `tags`                 - A map for setting AWS tags.

Usage
-----

```hcl
module "ec2_instance" {
  source               = "github.com/kvootla/Terraform-Groundwork//tf-aws-ec2"
 
  instance_type       = "${var.instance_type}"
  instance_name       = "${var.instance_name}"
  ami_id              = "${var.ami_id}"
  aws_access_key      = "${var.aws_access_key}"
  aws_secret_key      = "${var.aws_secret_key}"
  aws_region          = "${var.aws_region}"
  subnet_id           = "${var.subnet_id}"
  number_of_instances = "${var.number_of_instances}"
  user_data           = "${var.user_data}"
}
```

Outputs
=======

- `ec2_instance_id` - EC2 Instance ID
