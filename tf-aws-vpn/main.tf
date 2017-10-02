/*
 * Inputs
 */

variable "vpc_id" {
  description = "VPC ID where vpn Gateway(s) will be attached."
}

variable "enable_vgw_route_propagation" {
  description = "Whether the routes known to the Virtual Private Gateway, are propagated to the route tables listed in the route_table_ids listed. Accepts either true of false."
  default     = false
}

variable "customer_gateway_id" {
  description = "customer gateway id"
  default     = true
}

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
 * vpn Gateway
 */

resource "aws_vpn_gateway" "main" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name         = "${var.environment == "" ? var.organization : format("%s-%s", var.organization, var.environment)}-vpn"
    Organization = "${var.organization}"
    Terraform    = "true"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpn_gateway_attachment" "main" {
  vpc_id         = "${var.vpc_id}"
  vpn_gateway_id = "${aws_vpn_gateway.main.id}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_customer_gateway" "main" {
  bgp_asn    = "${var.bgp_asn}"
  ip_address = "${var.ip_address}"
  type       = "ipsec.1"
  count  = "${var.customer_gateway_id ? 1 : 0}"

  tags {
    Name         = "${var.environment == "" ? var.organization : format("%s-%s", var.organization, var.environment)}-vpn"
    Organization = "${var.organization}"
    Terraform    = "true"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpn_connection" "main" {
  vpn_gateway_id      = "${aws_vpn_gateway.main.id}"
  customer_gateway_id = "${aws_customer_gateway.main.id}"
  type                = "ipsec.1"

  tags {
    Name         = "${var.environment == "" ? var.organization : format("%s-%s", var.organization, var.environment)}-vpn"
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

output "vgw_id" {
  value = "${aws_vpn_gateway.main.id}"
}

output "cgw_id" {
  value = "${aws_customer_gateway.main.id}"
}

output "cgw_ip_address" {
  value = "${aws_customer_gateway.main.ip_address}"
}

output "cgw_bgp_asn" {
  value = "${aws_customer_gateway.main.bgp_asn}"
}
