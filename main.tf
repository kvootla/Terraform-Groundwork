provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

# Assign AWS EIP to AWS EC2
resource "aws_eip" "eip" {
  instance = "${element(split(",", var.instance_ids), count.index)}"
  vpc      = "${var.vpc}"
  count    = "${length(split(",", var.instance_ids))}"
}
