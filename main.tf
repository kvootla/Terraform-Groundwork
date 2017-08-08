/**
 * Inputs
 */

variable "sg_type" {
  description = "The type of traffic the security group is enabling."
  default     = "rabbitmq"
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
 * Security Groups/Rabbitmq
 */

resource "aws_security_group" "main_security_group" {
  name   = "${format("%s-%s-%s", var.organization, var.environment, var.sg_type)}"
  vpc_id = "${var.vpc_id}"

  // allow traffic for TCP 5671
  ingress {
    from_port       = 5671
    to_port         = 5671
    protocol        = "tcp"
    cidr_blocks     = ["${var.source_cidr_blocks}"]
    security_groups = ["${var.source_security_groups}"]
    self            = "${var.self_ingress}"
  }

  // allow traffic for TCP 5672
  ingress {
    from_port       = 5672
    to_port         = 5672
    protocol        = "tcp"
    cidr_blocks     = ["${var.source_cidr_blocks}"]
    security_groups = ["${var.source_security_groups}"]
    self            = "${var.self_ingress}"
  }

  // allow traffic for TCP 15671
  ingress {
    from_port       = 15671
    to_port         = 15671
    protocol        = "tcp"
    cidr_blocks     = ["${var.source_cidr_blocks}"]
    security_groups = ["${var.source_security_groups}"]
    self            = "${var.self_ingress}"
  }

  // allow traffic for TCP 15672
  ingress {
    from_port       = 15672
    to_port         = 15672
    protocol        = "tcp"
    cidr_blocks     = ["${var.source_cidr_blocks}"]
    security_groups = ["${var.source_security_groups}"]
    self            = "${var.self_ingress}"
  }

  // allow traffic for TCP 25672
  ingress {
    from_port       = 25672
    to_port         = 25672
    protocol        = "tcp"
    cidr_blocks     = ["${var.source_cidr_blocks}"]
    security_groups = ["${var.source_security_groups}"]
    self            = "${var.self_ingress}"
  }

  // allow traffic for TCP 4369
  ingress {
    from_port       = 4369
    to_port         = 4369
    protocol        = "tcp"
    cidr_blocks     = ["${var.source_cidr_blocks}"]
    security_groups = ["${var.source_security_groups}"]
    self            = "${var.self_ingress}"
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
