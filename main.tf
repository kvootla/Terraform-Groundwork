/**
 * Inputs
 */

variable "cidrs" {
  type        = "string"
  description = "A map with key being the availability zone and value the CIDR range."
}

variable "vpc_id" {
  description = "The VPC ID."
}

variable "igw_id" {}

variable "map_public_ip_on_launch" {
  default = false
}

variable "availability_zone" {
  description = "A list of availability zones inside the VPC"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}


/**
 * Subnets
 */

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "${var.aws_region}"
}

resource "aws_subnet" "main" {
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${var.cidrs[element(keys(var.cidrs), count.index)]}"
  availability_zone       = "${element(keys(var.cidrs), count.index)}"
  count                   = "${length(keys(var.cidrs))}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"

  lifecycle {
    create_before_destroy = true
  }
}


/**
 * Routes
 */

resource "aws_route_table" "main" {
  vpc_id = "${var.vpc_id}"
  count  = 1
}

resource "aws_route_table_association" "main" {
  subnet_id      = "${element(aws_subnet.main.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.main.*.id, count.index)}"
  count                   = "${length(keys(var.cidrs))}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route" "igw" {
  route_table_id         = "${element(aws_route_table.main.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${var.igw_id}"
  count                   = "${length(keys(var.cidrs))}"

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

output "subnet_ids" {
  value = [
    "${aws_subnet.main.*.id}"
  ]
}

output "route_table_ids" {
  value = [
    "${aws_route_table.main.*.id}"
  ]
}
