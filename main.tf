provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${var.vpc_id}"
     tags { Name = "${var.name}" }
}
