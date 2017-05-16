/**
 * Inputs
 */

variable "vpc_id" {
  type        = "string"
  description = "The ID of the VPC"
}

variable "domain_name" {
  type        = "string"
  description = "The suffix domain name to use by default when resolving non Fully Qualified Domain Names"
  default     = ""
}

variable "name_servers" {
  description = "List of name servers to configure in '/etc/resolv.conf'"
  default     = ["AmazonProvidedDNS"]
}

variable "netbios_name_servers" {
  description = "List of NETBIOS name servers"
  default     = []
}

variable "netbios_node_type" {
  type        = "string"
  description = "The NetBIOS node type (1, 2, 4, or 8). AWS recommends to specify 2 since broadcast and multicast are not supported in their network."
  default     = ""
}

variable "ntp_servers" {
  type        = "list"
  description = "List of NTP servers to configure"
  default     = []
}

variable "organization" {
  description = "Organization the VPC is for."
}

variable "environment" {
  description = "Environment the VPC is for."
  default     = ""
}


/**
 * DHCP_Option
 */

resource "aws_vpc_dhcp_options" "dhcp" {
  domain_name          = "${var.domain_name}"
  domain_name_servers  = ["${compact(var.name_servers)}"]
  netbios_name_servers = ["${compact(var.netbios_name_servers)}"]
  netbios_node_type    = "${var.netbios_node_type}"
  ntp_servers          = ["${compact(var.ntp_servers)}"]

  tags {
    Name         = "${var.environment == "" ? var.organization : format("%s-%s", var.organization, var.environment)}-dhcp"
    Organization = "${var.organization}"
    Terraform    = "true"
  }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  dhcp_options_id = "${aws_vpc_dhcp_options.dhcp.id}"
  vpc_id          = "${var.vpc_id}"
}


/**
 * Outputs
 */

output "dhcp_id" {
  value = "${aws_vpc_dhcp_options.dhcp.id}"
}
