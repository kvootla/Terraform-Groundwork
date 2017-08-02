/**
 * Input Variables
 */

variable "vpc_cidr" {}

variable "vpc_id" {}

variable "availability_zones" {
  description = "A list of availability zones inside the VPC"
}

variable "enable_dns_hostnames" {
  description = "True to use private DNS within the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "True to use private DNS within the VPC"
  default     = true
}

variable "private_propagating_vgws" {
  description = "A list of VGWs the private route table should propagate."
  default     = []
}

variable "private_subnets" {
  default = "A list of public subnets inside the VPC"
}

variable "map_public_ip_on_launch" {
  description = "True to auto-assign public IP on launch"
  default     = true
}

variable "public_propagating_vgws" {
  description = "A list of VGWs the public route table should propagate."
  default     = []
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
}

variable "name" {
  description = "Name tag, e.g stack"
  default     = "subnet"
}

variable "environment" {
  description = "Environment tag, e.g prod"
}

/**
 * Subnets
 */

resource "aws_subnet" "private_subnet" {
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${var.private_subnets}"
  availability_zone       = "${var.availability_zones}"
  map_public_ip_on_launch = false

  tags {
    Name        = "${format("private")}-${var.name}"
    Environment = "${var.environment}"
    Terraform   = "true"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${var.public_subnets}"
  availability_zone       = "${var.availability_zones}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"

  tags {
    Name        = "${format("public")}-${var.name}"
    Environment = "${var.environment}"
  }
}

/**
 * Outputs Varibales
 */

output "private_subnet_ids" {
  value = ["${aws_subnet.private_subnet.*.id}"]
}

output "private_subnet_cidr_blocks" {
  value = ["${aws_subnet.private_subnet.*.cidr_block}"]
}

output "public_subnet_cidr_blocks" {
  value = ["${aws_subnet.public_subnet.*.cidr_block}"]
}

output "public_subnet_ids" {
  value = ["${aws_subnet.public_subnet.*.id}"]
}