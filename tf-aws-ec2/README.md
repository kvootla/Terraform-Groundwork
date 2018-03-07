Module: AWS/EC2 Instance
========================

A Terraform module for creating ec2 instances.


Module Input Variables
----------------------

- `instance_type`                     - Instance type, see a list at: https://aws.amazon.com/ec2/instance-types/"
- `ami_id`                            - AMI to serve as base of server build.
- `security_groups`                   - list of security group IDs.
- `subnet_id`                         - The VPC subnet to place the instance.
- `private_ip`                        - Private IP address.
- `key_name`                          - The SSH key pair.
- `root_block_volume_size`            - Root block volume size.
- `root_block_volume_type`            - Root block volume type.
- `user_data`                         - User data for the instances.
- `root_block_delete_on_termination`  - Delete root block on instance termination.
- `environment`                       - Environment tag for the instance, e.g prod"
- `organization`                      - Organization tag for the instance, e.g. dchbx"
- `application`                       - Application tag for the instance, e.g. enroll"

Usage
-----

```hcl
module "aws_instance" {
  source                = "github.com/kvootla/Terraform-Groundwork//tf-aws-ec2"
 
  ami                    = "${var.ami_id}"
  key_name               = "${var.key_name}"
  user_data              = "${var.user_data}"
  subnet_id              = "${var.subnet_id}"
  private_ip             = "${var.private_ip}"
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = ["${var.security_groups}"]

  monitoring         	 = true
  source_dest_check      = true

  volume_type            = "${var.root_block_volume_type}"
  volume_size            = "${var.root_block_volume_size}"
  delete_on_termination  = "${var.root_block_delete_on_termination}"

  Organization           = "${var.organization}"
  Environment            = "${var.environment}"
}
```

Outputs
=======

- `ec2_instance_id` - EC2 Instance ID
