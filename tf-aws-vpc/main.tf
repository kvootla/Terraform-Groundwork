/**
 * Inputs
 */

variable "cidr" {
  description = "The CIDR block for the VPC."
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames (default: true)."
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS support (default: true)."
  default     = true
}

variable "create_igw" {
  description = "Create an Internet Gateway (default: true)"
  default     = true
}

variable "organization" {
  description = "Organization the VPC is for."
}

variable "environment" {
  description = "Environment the VPC is for."
  default     = ""
}

/**
 * VPC
 */

resource "aws_vpc" "main" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"

  tags {
    Name         = "${var.environment == "" ? var.organization : format("%s-%s", var.organization, var.environment)}-vpc"
    Organization = "${var.organization}"
    Terraform    = "true"
  }
}

/**
 * Internet Gateway
 */

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"
  count  = "${var.create_igw ? 1 : 0}"

  tags {
    Name         = "${var.environment == "" ? var.organization : format("%s-%s", var.organization, var.environment)}-igw"
    Organization = "${var.organization}"
    Terraform    = "true"
  }
}

/**
 * Outputs
 */

// The VPC ID
output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

// The Internet Gateway ID
output "igw_id" {
  value = ["${aws_internet_gateway.main.*.id}"]
}
