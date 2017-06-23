/*
 * Inputs
 */

variable "aws_vpc.requester.id" {}

variable "aws_vpc.accepter.id" {}

variable "organization" {
  description = "Organization the VPC is for."
}

variable "environment" {
  description = "Environment the VPC is for."
  default     = ""
}


/**
 * VPC Peering
 */

resource "aws_vpc_peering_connection" "main" {
  peer_vpc_id   = "${aws_vpc.requester.id}"
  vpc_id        = "${aws_vpc.accepter.id}"
  auto_accept   = true

 tags {
    Name         = "${var.environment == "" ? var.organization : format("%s-%s", var.organization, var.environment)}-VPN"
    Organization = "${var.organization}"
    Terraform    = "true"
  }

  lifecycle {
    create_before_destroy = true
  }
}


/**
 * Outputs
 */

output "vpc_peering_id" {
  value = "${aws_aws_vpc_peering_connection.main.id}"
}
