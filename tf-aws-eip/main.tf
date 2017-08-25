/**
 * Inputs
 */

variable "vpc_id" {
  default = true
}

variable "instance_ids" {
  description = "The instance ID for which elastic ip is tagged."
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
 * Outputs
 */

output "id" {
  value = "${aws_eip.main.id}"
}

output "public_ip" {
  value = "${aws_eip.main.public_ip}"
}
