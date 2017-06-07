/**
* Inputs
*/

variable "allocation_id" {}
variable "subnet_id" {}

/**
* NAT Gateway
*/

resource "aws_nat_gateway" "main" {
  allocation_id = "${var.allocation_id}"
  subnet_id     = "${var.subnet_id}"
}

/**
* Outputs
*/

output "id" {
  value = "${aws_nat_gateway.main.id}"
}

output "eni_id" {
  value = "${aws_nat_gateway.main.network_interface_id}"
}

output "public_ip" {
  value = "${aws_nat_gateway.main.public_ip}"
}

output "private_ip" {
  value = "${aws_nat_gateway.main.private_ip}"
}
