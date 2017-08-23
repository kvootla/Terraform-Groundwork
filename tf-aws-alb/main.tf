/**
 * Input Variables
 */

variable "internal" {
  description = "Determines if the ALB is internal. Default: false"
  default     = false
}

variable "log_bucket" {
  description = "S3 bucket for storing ALB access logs."
}

variable "log_prefix" {
  description = "S3 prefix within the log_bucket under which logs are stored."
}

variable "subnet_group_a1" {
  description = "The subnet for availability zone 1"
}

variable "subnet_group_a2" {
  description = "The subnet for availability zone 2"
}

variable "security_group_id" {
  description = "List of security group IDs"
}

variable "application" {
  description = "Application that will use the cache"
}

variable "organization" {
  description = "Organization the ALB is for."
}

variable "environment" {
  description = "Environment the ALB is for."
  default     = ""
}

/**
 * Application Load Balancer
 */

resource "aws_alb" "alb_loging" {
  name               = "alb-${var.organization}-${var.environment}-${var.application}"
  subnets         = ["${var.subnet_group_a1}", "${var.subnet_group_a2}"] 
  security_groups = ["${var.security_group_id}"]
  internal           = "${var.internal}"

  access_logs {
    bucket = "${var.log_bucket}"
    prefix = "${var.log_prefix}"
  }

  count = "${var.log_bucket != "" && var.log_prefix != "" ? 1 : 0}"
}

resource "aws_alb" "alb_nologing" {
  name               = "elb-${var.organization}-${var.environment}-${var.application}"
  subnet_ids         = ["${split(",", var.subnet_ids)}"]
  security_group_ids = ["${split(",", var.security_group_ids)}"]
  internal           = "${var.internal}"

  count = "${(var.log_bucket == "" || var.log_prefix == "") ? 1 : 0}"
}

/**
 * Outputs Varibales
 */

output "dns_name" {
  value = "${aws_alb.alb_loging.dns_name}"
}

output "id" {
  value = "${aws_alb.alb_loging.id}"
}

output "zone_id" {
  value = "${aws_alb.alb_loging.zone_id}"
}
