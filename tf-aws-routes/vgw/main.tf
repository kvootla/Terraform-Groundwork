/**
* Inputs
*/

variable "route_table_id" {
  description = "Route Table ID"
}

variable "cidr_block" {
  description = "Destination CIDR Block"
}

variable "vgw_id" {
  description = "Virtual Private Gateway ID"
}

/**
* Virtual Private Gateway Route
*/

resource "aws_route" "main" {
  route_table_id         = "${var.route_table_id}"
  destination_cidr_block = "${var.cidr_block}"
  gateway_id             = "${var.vgw_id}"
}
