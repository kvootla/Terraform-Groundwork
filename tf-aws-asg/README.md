Module: AWS/Auto Scaling Groups
===============================

A Terraform module for creating an Auto-Scaling Group and a launch configuration for it.


Module Input Variables
----------------------

- `name`                 - The launch configuration and auto scaling group name.
- `ami_id`               - AMI ID.
- `instance_type`        - Type of instance.
- `iam_instance_profile` - The ARN of the instance profile the LC should launch the instances.
- `key_name`             - The SSH key name (uploaded to EC2) instances should be populated.
- `security_group`       - The Security Group ID that instances in the ASG.
- `user_data`            - The path to the user_data file for the Launch Configuration.
- `availability_zones`              - The list of AZs, comma separated list
- `asg_number_of_instances`         - The number of instances we want in the ASG
- `asg_minimum_number_of_instances` - The minimum number of instances the ASG should maintain
- `health_check_grace_period`       - Number of seconds for the health check time out (Defaults to 300).
- `health_check_type`               - The health check type.
- `application` 	- Application that will use the cache (lowercase abbreviations)
- `organization` 	- Organization the ALB is for (lowercase abbreviations)
- `environment` 	- Environment the ALB is for (lowercase abbreviations)

Usage
-----

```hcl
module "autoscaling_group" {
  source               = "github.com/kvootla/Terraform-Groundwork//tf-aws-asg"

  name                 = "${var.organization}-${var.environment}-${var.application}-{var.lc_name}-elb"
  image_id             = "${var.ami_id}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${var.iam_instance_profile}"
  key_name             = "${var.key_name}"
  security_groups      = ["${var.security_group}"]
  user_data            = "${file(var.user_data)}"

  depends_on           = ["aws_launch_configuration.launch_config"]
  name                 = "${var.organization}-${var.environment}-${var.application}-elb"
  availability_zones   = ["${split(",", var.azs)}"]
  vpc_zone_identifier  = ["${split(",", var.subnet_group_ids)}"]
  launch_configuration = "${aws_launch_configuration.launch_config.id}"

  max_size                  = "${var.asg_maximum_number_of_instances}"
  min_size                  = "${var.asg_minimum_number_of_instances}"
  desired_capacity          = "${var.asg_number_of_instances}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"
}
```

Outputs
=======

- `launch_config_id` - Launch Configuration ID
- `asg_id`           - ASG ID
