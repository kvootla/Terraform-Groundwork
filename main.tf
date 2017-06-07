/**
 * Input Variables
 */

variable "vpc" {
  default = true
}

variable "instance_ids" {
  default = ""
}

/**
 * Elastic IP
 */

resource "aws_eip" "eip" {
  instance = "${element(split(",", var.instance_ids), count.index)}"
  vpc      = "${var.vpc}"
  count    = "${length(split(",", var.instance_ids))}"
}

/**
 * Outputs Varibales
 */

output "public_ip" {
  value = "${aws_eip.eip.public_ip}"
}
