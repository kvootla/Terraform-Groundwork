/*
 * Inputs
 */

variable "vpc_id" {
  description = "VPC ID where VPN Gateway(s) will be attached."
}

variable "enable_vgw_route_propagation" {
  description = "Whether the routes known to the Virtual Private Gateway, are propagated to the route tables listed in the route_table_ids listed. Accepts either true of false."
  default     = false
}

variable "customer_gateway_id" {
  description = "customer gateway id"
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
 * VPN Gateway
 */

resource "aws_vpn_gateway" "main" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name         = "${var.environment == "" ? var.organization : format("%s-%s", var.organization, var.environment)}-dhcp"
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

resource "aws_vpn_connection" "main" {
  vpn_gateway_id = "${aws_vpn_gateway.main.id}"
  customer_gateway_id = "${var.customer_gateway_id}"
  type           = "ipsec.1"

  tags {
    Name         = "${var.environment == "" ? var.organization : format("%s-%s", var.organization, var.environment)}-dhcp"
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
