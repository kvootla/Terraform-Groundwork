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

// Providers used in this module
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}

//------------------------------------------------------------------------------------------------------------------------------
/**
 * Resource for EC2 Instance
 */

// Configuration for the Providers :
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

//VPC Resource for Module
resource "aws_vpc" "mod" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"
  tags                 = "${merge(var.tags, map("Name", format("%s", var.name)))}"
  }

//------------------------------------------------------------------------------------------------------------------------------
/**
 * Outputs Varibales
 */

// Output for the VPC
output "vpc_id" {
  value = "${aws_vpc.mod.id}"
}

