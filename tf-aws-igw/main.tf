/**
 * Input Variables
 */

variable "vpc_id" {}

variable "application" {
  description = "Application that will use the cache"
}

variable "organization" {
  description = "Organization the VPC is for."
}

variable "environment" {
  description = "Environment the VPC is for."
  default     = ""
}

variable "environment" {
  description = "Environment tag, e.g prod"
}

/**
 * Internet Gateway
 */

resource "aws_internet_gateway" "main" {
  vpc_id = "${var.vpc_id}"
  name   = "${var.organization}-${var.environment}-${var.application}-igw"

  tags {
    Name         = "${format("%s-%s-%s", var.organization, var.environment, var.application)}-igw"
    Organization = "${var.organization}"
    Terraform    = "true"
  }
}

/**
 * Outputs Varibales
 */

output "igw_id" {
  value = "${aws_internet_gateway.main.id}"
}
