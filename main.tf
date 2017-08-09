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

variable "security_group_ids" {
  description = "A comma separated string of sg's with which we associate the ALB."
}

variable "subnet_ids" {
  description = "A comma delimited list of subnets to associate with the ALB."
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
  name               = "elb-${var.organization}-${var.environment}-${var.application}"
  subnet_ids         = ["${split(",", var.subnet_ids)}"]
  security_group_ids = ["${split(",", var.security_group_ids)}"]
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
  value = "${var.alb_loging.dns_name}"
}

output "id" {
  value = "${var.alb_loging.id}"
}

output "zone_id" {
  value = "${var.alb_loging.zone_id}"
}
