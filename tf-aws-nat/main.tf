/**
* Inputs
*/

variable "public_subnet_id" {}

/**
 * Nat Gateway
 */

resource "aws_eip" "main" {
  vpc = true
}

resource "aws_nat_gateway" "main" {
  allocation_id = "${aws_eip.main.id}"
  subnet_id     = "${var.public_subnet_id}"
}

/**
 * Outputs
 */

output "nat_id" {
  value = "${aws_nat_gateway.main.id}"
}
