/**
* Inputs
*/

variable "allocation_id" {}
variable "subnet_id" {}

/**
 * Nat
 */
resource "aws_eip" "main" {
  vpc   = true
}

resource "aws_nat_gateway" "main" {
  allocation_id = "${element(aws_eip.main.*.id, count.index)}"
  subnet_id     = "${var.public_subnet_id}"
}

/**
 * Outputs Varibales
 */

output "nat_eips" {
  value = [
    "${aws_eip.main.*.public_ip}"
  ]
}
