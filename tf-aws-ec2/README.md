Module: AWS/EC2 Instance
========================

A Terraform module for making ec2 instances.


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
