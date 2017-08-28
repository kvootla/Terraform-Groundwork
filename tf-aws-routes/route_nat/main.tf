/**
 * Inputs
 */

variable "vpc_id" {
  description = "The VPC ID."
}

variable "subnet_id" {
  description = "The VPC subnet the instance(s) will go in"
}

variable "nat_id" {
  description = "The NAT Gateway ID."
}

variable "organization" {
  description = "Organization the VPC is for."
}

variable "environment" {
  description = "Environment the VPC is for."
  default     = ""
}

/**
 * Routes/Nat Gateway
 */

resource "aws_route_table" "main" {
  vpc_id = "${var.vpc_id}"
  count  = 1

  tags {
    Name         = "${var.environment == "" ? var.organization : format("%s-%s", var.organization, var.environment)}-igw"
    Organization = "${var.organization}"
    Terraform    = "true"
  }
}

resource "aws_route_table_association" "main" {
  subnet_id      = "${var.subnet_id}"
  route_table_id = "${aws_route_table.main.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route" "nat" {
  route_table_id         = "${aws_route_table.main.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${var.nat_id}"
  count                  = 1

  depends_on = [
    "aws_route_table.main",
  ]

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
