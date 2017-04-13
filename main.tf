/**
 * Input Variables
 */

variable "aws_region" {}
variable "vpc_cidr" {}
variable "vpc_name" {}

variable "availability_zones" {
  default = []
}

variable "enable_dns_hostnames" {
  description = "True to use private DNS within the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "True to use private DNS within the VPC"
  default     = true
}

variable "map_public_ip_on_launch" {
  description = "True to auto-assign public IP on launch"
  default     = true
}

variable "private_propagating_vgws" {
  description = "A list of VGWs the private route table should propagate."
  default     = []
}

variable "private_subnets" {
  default = []
}

variable "public_propagating_vgws" {
  description = "A list of VGWs the public route table should propagate."
  default     = []
}

variable "public_subnets" {
  default = []
}


/**
 * Routes
 */

// Routes
resource "aws_route" "private_aws_route" {
  count                  = "${length(var.private_subnets)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.nat_gateway.*.id, count.index)}"
  route_table_id         = "${element(aws_route_table.private_route_table.*.id, count.index)}"
}

resource "aws_route" "public_aws_route" {
  route_table_id         = "${aws_route_table.public_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet_gateway.id}"
}

// Routes Table
resource "aws_route_table" "private_route_table" {
  vpc_id           = "${aws_vpc.vpc.id}"
  propagating_vgws = ["${var.public_propagating_vgws}"]
  count            = "${length(var.private_subnets)}"

  tags {
    Name = "${var.vpc_name}-private-rt-${element(var.availability_zones, count.index)}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id           = "${aws_vpc.vpc.id}"
  propagating_vgws = ["${var.public_propagating_vgws}"]

  tags {
    Name = "${var.vpc_name}-public-rt"
  }
}

// Routes Table Association
resource "aws_route_table_association" "public_route_table_association" {
  count          = "${length(var.public_subnets)}"
  subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public_route_table.*.id, count.index)}"
}

resource "aws_route_table_association" "private_route_table_association" {
  count          = "${length(var.private_subnets)}"
  subnet_id      = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private_route_table.*.id, count.index)}"
}


/**
 * Outputs Varibales
 */

 output "flow_log_cloudwatch_log_group_arn" {
  value = "${aws_cloudwatch_log_group.cloudwatch_log_group.arn}"
}

#output "flow_log_cloudwatch_log_group_name" {
#  value = "${aws_cloudwatch_log_group.cloudwatch_log_group.name}"
#}

output "flow_log_cloudwatch_log_stream_arn" {
  value = "${aws_cloudwatch_log_stream.cloudwatch_log_stream.arn}"
}

output "internet_gateway_id" {
  value = "${aws_internet_gateway.internet_gateway.id}"
}

output "nat_eips" {
  value = ["${aws_eip.eip.*.id}"]
}

output "private_route_table_ids" {
  value = ["${aws_route_table.private_route_table.*.id}"]
}

output "private_subnet_ids" {
  value = ["${aws_subnet.private_subnet.*.id}"]
}

output "private_subnet_cidr_blocks" {
  value = ["${aws_subnet.private_subnet.*.cidr_block}"]
}

output "public_route_table_ids" {
  value = ["${aws_route_table.public_route_table.*.id}"]
}

output "public_subnet_cidr_blocks" {
  value = ["${aws_subnet.public_subnet.*.cidr_block}"]
}

output "public_subnet_ids" {
  value = ["${aws_subnet.public_subnet.*.id}"]
}

output "vpc_cidr_block" {
  value = "${aws_vpc.vpc.cidr_block}"
}

output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}
