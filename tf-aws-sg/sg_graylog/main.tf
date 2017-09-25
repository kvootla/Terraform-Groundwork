/**
 * Inputs
 */

variable "sg_type" {
  description = "The type of traffic the security group is enabling."
  default     = "graylog"
}

variable "vpc_id" {
  description = "The VPC this security group will go in"
}

variable "source_cidr_blocks" {
  description = "A list of source CIDR blocks to allow traffic from"
  type        = "list"
  default     = []
}

variable "source_security_groups" {
  description = "A list of source security groups to allow traffic from"
  type        = "list"
  default     = []
}

variable "self_ingress" {
  description = "Include security group itself as a source to this ingress rule"
  default     = "false"
}

variable "organization" {
  description = "Organization the security group is for."
}

variable "environment" {
  description = "Environment the security group is for."
  default     = ""
}

/**
 * Security Groups/Graylog
 */

resource "aws_security_group" "main_security_group" {
  name   = "${format("%s-%s-%s", var.organization, var.environment, var.sg_type)}"
  vpc_id = "${var.vpc_id}"

  // allow traffic for TCP 12900
  ingress {
    from_port       = 12900
    to_port         = 12900
    protocol        = "tcp"
    cidr_blocks     = ["${var.source_cidr_blocks}"]
    security_groups = ["${var.source_security_groups}"]
    self            = "${var.self_ingress}"
  }

  // allow traffic for TCP 9000
  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["${var.source_cidr_blocks}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
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
