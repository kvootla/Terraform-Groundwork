/**
 * Input Variables
 */

variable "vpc_cidr" {}

variable "vpc_id" {}

variable "availability_zones" {
  description = "A list of availability zones inside the VPC"
}

variable "map_public_ip_on_launch" {
  description = "True to auto-assign public IP on launch"
  default     = true
}

variable "public_propagating_vgws" {
  description = "A list of VGWs the public route table should propagate."
  default     = []
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}


variable "igw_id" {}

  
/**
 * Subnets
 */

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

resource "aws_subnet" "main" {
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${var.public_subnets}"
  availability_zone       = "${var.availability_zones}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
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
  count          = "${length(keys(var.public_subnets))}"

  lifecycle {
    create_before_destroy = true
  }
}

/**
 * Outputs Varibales
 */


output "public_subnet_cidr_blocks" {
  value = ["${aws_subnet.main.*.cidr_block}"]
}

output "public_subnet_ids" {
  value = ["${aws_subnet.main.*.id}"]
}

output "route_table_ids" {
  value = [
    "${aws_route_table.main.*.id}"
  ]
}
