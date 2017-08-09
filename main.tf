/**
 * Input Variables
 */

variable "vpc_id" {
  default = true
}

variable "instance_ids" {
  default = ""
}

/**
 * Elastic IP
 */

resource "aws_eip" "main" {
  vpc      = "${var.vpc_id}"
  count    = "${length(split(",", var.instance_ids))}"
  instance = "${element(split(",", var.instance_ids), count.index)}"
}

/**
 * Outputs Varibales
 */

output "public_ip" {
  value = "${aws_eip.eip.public_ip}"
}
