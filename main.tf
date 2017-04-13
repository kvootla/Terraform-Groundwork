/**
 * Input Variables
 */

variable "vpc" { default = true }
variable "instance_ids" { default = "" }
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}


/**
 * Resource for Elastic IP
 */

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

# Assign AWS EIP to AWS EC2
resource "aws_eip" "eip" {
  instance = "${element(split(",", var.instance_ids), count.index)}"
  vpc      = "${var.vpc}"
  count    = "${length(split(",", var.instance_ids))}"
}


/**
 * Outputs Varibales
 */

output "public_ip" { value = "${aws_eip.eip.public_ip}" }
