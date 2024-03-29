/**
 * Inputs
 */

variable "vpc_id" {}

variable "organization" {
  description = "Organization the VPC is for."
}

variable "environment" {
  description = "Environment the VPC is for."
  default     = ""
}

/**
 * Internet Gateway
 */

resource "aws_internet_gateway" "igw" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name         = "${format("%s-%s", var.organization, var.environment)}-igw"
    Organization = "${var.organization}"
    Terraform    = "true"
  }
}

/**
 * Outputs
 */

output "igw_id" {
  value = "${aws_internet_gateway.igw.id}"
}
