/**
 * Input Variables
 */

variable "name" {
  default = "igw"
}

variable "vpc_id" {}

variable "route_table_id" {
  description = "the igw in particular route table with in the subnet"
}

variable "igw_id" {
  description = "The Internet Gateway ID."
}

variable "environment" {
  description = "Environment tag, e.g prod"
}

/**
 * Internet Gateway
 */

resource "aws_internet_gateway" "igw" {
  vpc_id = "${var.vpc_id}"
  route_table_id         = "${var.route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${var.igw_id}"

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
