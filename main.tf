/**
 * Input Variables
 */

variable "name" {
  default = "igw"
}

variable "vpc_id" {}

variable "subnet_id" {
  description = "The VPC subnet the instance(s) will go in"
}

variable "environment" {
  description = "Environment tag, e.g prod"
}

/**
 * Internet Gateway
 */

resource "aws_internet_gateway" "igw" {
  vpc_id = "${var.vpc_id}"
  subnet_id      = "${var.subnet_id}"

  tags {
    Name        = "${var.name}"
    Environment = "${var.environment}"
    Terraform   = "true"
  }
}

/**
 * Outputs Varibales
 */

output "igw_id" {
  value = "${aws_internet_gateway.igw.id}"
}
