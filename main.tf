// Create Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = "${var.vpc.id}"
  cidr_block              = "${var.private_subnets[count.index]}"
  availability_zone       = "${var.availability_zones[count.index]}"
  map_public_ip_on_launch = false
  }

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}


// Create Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${var.public_subnets}"
  availability_zone       = "${var.availability_zones}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
}
