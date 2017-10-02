/*
 * Inputs
 */

variable "ip_address" {
  description = "IP address of the Customer Gateway external interface."
}

variable "bgp_asn" {
  description = "BGP ASN of the Customer Gateway. By convention, use 65000 if you are not running BGP."
}

variable "organization" {
  description = "Organization the VPC is for."
}

variable "environment" {
  description = "Environment the VPC is for."
  default     = ""
}

/**
 * Customer Gateways
 */

resource "aws_customer_gateway" "main" {
  bgp_asn    = "${var.bgp_asn}"
  ip_address = "${var.ip_address}"
  type       = "ipsec.1"

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

output "cgw_id" {
  value = "${aws_customer_gateway.main.id}"
}

output "cgw_ip_address" {
  value = "${aws_customer_gateway.main.ip_address}"
}

output "cgw_bgp_asn" {
  value = "${aws_customer_gateway.main.bgp_asn}"
}
