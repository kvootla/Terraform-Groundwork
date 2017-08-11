/**
 * Input Variables
 */

variable "lc_name" {}
variable "ami_id" {}
variable "key_name" {}
variable "instance_type" {}
variable "iam_instance_profile" {}
variable "subnet_group_azs" {}

variable "health_check_type" {
  default = "EC2"
}

variable "azs" {
  description = "Availability Zones"
}

variable "security_group" {
  description = "The security group the instances to use"
}

variable "user_data" {
  description = "The path to a file with user_data for the instances"
}

variable "asg_maximum_number_of_instances" {
  description = "The maximum number of instances in the ASG should maintain"
}

variable "asg_minimum_number_of_instances" {
  description = "The minimum number of instances in the ASG should maintain"
  default     = 2
}

variable "health_check_grace_period" {
  description = "Number of seconds for a health check to time out"
  default     = 300
}

variable "application" {
  description = "Application that will use the cache"
}

variable "organization" {
  description = "Organization the VPC is for."
}

variable "environment" {
  description = "Environment the VPC is for."
  default     = ""
}

/**
 * Autoscaling Groups
 */

resource "aws_launch_configuration" "launch_config" {
  name                 = "${var.organization}-${var.environment}-${var.application}-{var.lc_name}-elb"
  image_id             = "${var.ami_id}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${var.iam_instance_profile}"
  key_name             = "${var.key_name}"
  security_groups      = ["${var.security_group}"]
  user_data            = "${file(var.user_data)}"
}

resource "aws_autoscaling_group" "asg" {
  depends_on           = ["aws_launch_configuration.launch_config"]
  name                 = "${var.organization}-${var.environment}-${var.application}-elb"
  availability_zones   = ["${split(",", var.azs)}"]
  vpc_zone_identifier  = ["${split(",", var.subnet_group_azs)}"]
  launch_configuration = "${aws_launch_configuration.launch_config.id}"

  max_size                  = "${var.asg_maximum_number_of_instances}"
  min_size                  = "${var.asg_minimum_number_of_instances}"
  desired_capacity          = "${var.asg_maximum_number_of_instances}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"
}

/**
 * Outputs Varibales
 */

output "launch_config_id" {
  value = "${aws_launch_configuration.launch_config.id}"
}

output "asg_id" {
  value = "${aws_autoscaling_group.asg.id}"
}
