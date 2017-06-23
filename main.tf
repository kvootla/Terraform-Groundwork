/*
 * Inputs
 */

variable "requester_id" {}

variable "accepter_id" {}

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
  peer_vpc_id = "${var.requester_id}"
  vpc_id      = "${var.accepter_id}"
  auto_accept = true

  tags {
    Name         = "${var.environment == "" ? var.organization : format("%s-%s", var.organization, var.environment)}-VPC_Peering"
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
  value = "${aws_vpc_peering_connection.main.id}"
}
