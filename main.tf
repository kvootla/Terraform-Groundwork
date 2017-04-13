/**
 * Input Variables
 */

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}

variable "alb_is_internal" {
  description = "Determines if the ALB is internal. Default: false"
  default     = false
}

variable "alb_name" {
  description = "The name of the ALB as will show in the AWS EC2 ELB console."
}

variable "alb_security_groups" {
  description = "A comma separated string of security groups with which we associate the ALB. e.g. 'sg-edcd9784,sg-edcd9785'"
}

variable "log_bucket" {
  description = "S3 bucket for storing ALB access logs."
}

variable "log_prefix" {
  description = "S3 prefix within the log_bucket under which logs are stored."
}

variable "subnets" {
  description = "A comma delimited list of subnets to associate with the ALB. e.g. 'subnet-1a2b3c4d,subnet-1a2b3c4e,subnet-1a2b3c4f'"
}


/**
 * Application Load Balancer
 */

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}
     
### ALB resources with a switch - logging enabled/disabled

resource "aws_alb" "alb_loging" {
  name            = "${var.alb_name}"
  subnets         = ["${split(",", var.subnets)}"]
  security_groups = ["${split(",", var.alb_security_groups)}"]
  internal        = "${var.alb_is_internal}"

  access_logs {
    bucket = "${var.log_bucket}"
    prefix = "${var.log_prefix}"
  }

  count = "${var.log_bucket != "" && var.log_prefix != "" ? 1 : 0}"
}

resource "aws_alb" "alb_nologing" {
  name            = "${var.alb_name}"
  subnets         = ["${split(",", var.subnets)}"]
  security_groups = ["${split(",", var.alb_security_groups)}"]
  internal        = "${var.alb_is_internal}"

  count = "${(var.log_bucket == "" || var.log_prefix == "") ? 1 : 0}"
}


/**
 * Outputs Varibales
 */

output "dns_name" {
  value = "${var.alb_loging.dns_name}"
  /*value = "${coalesce(list("var.alb_loging.dns_name", "var.alb_nologing.dns_name")) }"*/
}

output "id" {
  value = "${var.alb_loging.id}"
  /*value = "${coalesce(list("var.alb_loging.dns_name", "var.alb_nologing.dns_name")) }"*/
}

output "zone_id" {
  value = "${var.alb_loging.zone_id}"
  /*value = "${coalesce(list("var.alb_loging.dns_name", "var.alb_nologing.dns_name")) }"*/
}
