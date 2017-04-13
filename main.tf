/**
 * Input Variables
 */

variable "name" { default = "igw" }
variable "vpc_id" {}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}


/**
 * Resource for Internet Gateway
 */

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${var.vpc_id}"
     tags { Name = "${var.name}" }
}


/**
 * Outputs Varibales
 */

output "igw_id" { value = "${aws_internet_gateway.igw.id}" }
