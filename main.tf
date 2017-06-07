/**
 * Input Variables
 */

variable "lc_name" {}
variable "ami_id" {}
variable "instance_type" {}
variable "iam_instance_profile" {}
variable "key_name" {}

variable "security_group" {
  description = "The security group the instances to use"
}

variable "user_data" {
  description = "The path to a file with user_data for the instances"
}

variable "asg_name" {}

variable "asg_number_of_instances" {
  description = "The number of instances we want in the ASG"
}

variable "asg_minimum_number_of_instances" {
  description = "The minimum number of instances the ASG should maintain"
  default     = 1
}

variable "health_check_grace_period" {
  description = "Number of seconds for a health check to time out"
  default     = 300
}

variable "health_check_type" {
  default = "EC2"
}

variable "subnet_azs" {
  description = "The VPC subnet IDs"
}

variable "azs" {
  description = "Availability Zones"
}

/**
 * Autoscaling Groups
 */

resource "aws_launch_configuration" "launch_config" {
  name                 = "${var.lc_name}"
  image_id             = "${var.ami_id}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${var.iam_instance_profile}"
  key_name             = "${var.key_name}"
  security_groups      = ["${var.security_group}"]
  user_data            = "${file(var.user_data)}"
}

resource "aws_autoscaling_group" "main_asg" {
  depends_on          = ["aws_launch_configuration.launch_config"]
  name                = "${var.asg_name}"
  availability_zones  = ["${split(",", var.azs)}"]
  vpc_zone_identifier = ["${split(",", var.subnet_azs)}"]

  launch_configuration = "${aws_launch_configuration.launch_config.id}"

  max_size                  = "${var.asg_number_of_instances}"
  min_size                  = "${var.asg_minimum_number_of_instances}"
  desired_capacity          = "${var.asg_number_of_instances}"
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
  value = "${aws_autoscaling_group.main_asg.id}"
}
