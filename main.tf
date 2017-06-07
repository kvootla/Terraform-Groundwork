/**
 * Inputs
 */

variable "sg_type" {
  description = "The type of traffic the security group is enabling."
  default     = "ntp"
}

variable "vpc_id" {
  description = "The VPC this security group will go in"
}

variable "source_cidr_block" {
  description = "The source CIDR block to allow traffic from"
}

variable "organization" {
  description = "Organization the SG is for."
}

variable "environment" {
  description = "Environment the SG is for."
  default     = ""
}

/**
 * Security Groups/NTP
 */

resource "aws_security_group" "main_security_group" {
  name   = "${format("%s-%s-%s", var.organization, var.environment, var.sg_type)}"
  vpc_id = "${var.vpc_id}"

  // allow traffic for UDP 123
  ingress {
    from_port   = 123
    to_port     = 123
    protocol    = "udp"
    cidr_blocks = ["${var.source_cidr_block}"]
  }

  tags {
    Name         = "${format("%s-%s-%s", var.organization, var.environment, var.sg_type)}-sg"
    Organization = "${var.organization}"
    Terraform    = "true"
  }
}

/**
 * Outputs
 */

output "security_group_id" {
  value = "${aws_security_group.main_security_group.id}"
}
