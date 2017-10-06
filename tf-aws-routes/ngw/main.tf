/**
* Inputs
*/

variable "route_table_id" {
  description = "Route Table ID"
}

variable "cidr_block" {
  description = "Destination CIDR Block"
}

variable "ngw_id" {
  description = "NAT Gateway ID"
}

/**
* NAT Gateway Route
*/

resource "aws_route" "main" {
  route_table_id         = "${var.route_table_id}"
  destination_cidr_block = "${var.cidr_block}"
  nat_gateway_id         = "${var.ngw_id}"
}
