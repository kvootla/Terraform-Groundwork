/**
 * Inputs
 */

variable "sg_type" {
  description = "The type of traffic the security group is enabling."
  default     = "oracle"
}

variable "vpc_id" {
  description = "The VPC this security group will go in"
}

variable "source_cidr_blocks" {
  description = "A source CIDR blocks to allow traffic from"
}

variable "organization" {
  description = "Organization the security group is for."
}

variable "environment" {
  description = "Environment the security group is for."
  default     = ""
}

/**
 * Security Groups/Oracle
 */

resource "aws_security_group" "main_security_group" {
  name   = "${format("%s-%s-%s", var.organization, var.environment, var.sg_type)}"
  vpc_id = "${var.vpc_id}"

  // allow traffic for TCP 1521
  ingress {
    from_port       = 1521
    to_port         = 1521
    protocol        = "tcp"
    cidr_blocks     = "${var.source_cidr_blocks}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "0.0.0.0/0"
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

output "sg_id" {
  value = "${aws_security_group.main_security_group.id}"
}
