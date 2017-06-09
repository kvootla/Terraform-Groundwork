/**
 * Inputs
 */

variable "vpc_id" {
  description = "The VPC ID."
}

variable "subnet_id" {
  description = "The VPC subnet the instance(s) will go in"
}

variable "name" {}
variable "organization" {}
variable "environment" {}


/**
 * Routes
 */

resource "aws_route_table" "main" {
  vpc_id = "${var.vpc_id}"
  count  = 1

  tags {
    Name        = "${var.name}"
    Environment = "${var.environment}"
    Terraform   = "true"
  }
}

resource "aws_route_table_association" "main" {
  subnet_id      = "${var.subnet_id}"
  route_table_id = "${aws_route_table.main.id}"

  lifecycle {
    create_before_destroy = true
  }
}


/**
 * Outputs
 */

output "route_table_id" {
  value = "${aws_route_table.main.id}"
}

