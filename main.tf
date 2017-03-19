resource "aws_vpc" "mod" {
  cidr_block           = "${var.cidr}"
  name                 = "${var.name}"
}
