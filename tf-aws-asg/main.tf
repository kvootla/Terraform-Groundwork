/**
 * Input Variables
 */

variable "config_name" {}
variable "ami_id" {}
variable "key_name" {}
variable "instance_type" {}
variable "iam_instance_profile" {}

variable "health_check_type" {
  default = "EC2"
}

variable "azs" {
  description = "Availability Zones"
}

variable "security_group_ids" {
  description = "The security group the instances to use"
}

variable "subnet_group_ids" {
   description = "The subnet IDs with in the VPC"
 }

variable "user_data" {
  description = "The path to a file with user_data for the instances"
}

variable "max_number_of_instances" {
  description = "The maximum number of instances in the ASG should maintain"
}

variable "min_number_of_instances" {
  description = "The minimum number of instances in the ASG should maintain"
  default     = 2
}

variable "health_check_period" {
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
  name                 = "${var.organization}-${var.environment}-${var.application}-{var.config_name}-asg"
  image_id             = "${var.ami_id}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${var.iam_instance_profile}"
  key_name             = "${var.key_name}"
  security_groups      = ["${var.security_group_ids}"]
  user_data            = "${file(var.user_data)}"
}

resource "aws_autoscaling_group" "main" {
  depends_on           = ["aws_launch_configuration.launch_config"]
  name                 = "${var.organization}-${var.environment}-${var.application}-asg"
  availability_zones   = ["${split(",", var.azs)}"]
  vpc_zone_identifier  = ["${var.subnet_group_ids}"]
  launch_configuration = "${aws_launch_configuration.launch_config.id}"

  max_size                  = "${var.max_number_of_instances}"
  min_size                  = "${var.min_number_of_instances}"
  desired_capacity          = "${var.max_number_of_instances}"
  health_check_period = "${var.health_check_period}"
  health_check_type         = "${var.health_check_type}"
}

/**
 * Outputs Varibales
 */

output "launch_config_id" {
  value = "${aws_launch_configuration.launch_config.id}"
}

output "asg_id" {
  value = "${aws_autoscaling_group.main.id}"
}
