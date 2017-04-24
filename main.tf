/**
 * Input Variables
 */

variable "name" {}

variable "cidr" {}

variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = false
}

/**
 * VPC
 */

//VPC Resource for Module
resource "aws_vpc" "my_existing_vpc" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"
  tags                 = "${merge(var.tags, map("Name", format("%s", var.name)))}"
  }


/**
 * Outputs Varibales
 */

output "vpc_id" {
  value = "${aws_vpc.my_existing_vpc.id}"
}

