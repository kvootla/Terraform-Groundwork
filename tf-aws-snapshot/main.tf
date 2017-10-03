/**
 * Inputs
 */

variable "source_instance_id" {}

variable "snapshot_without_reboot" {
  default = "true"
}

variable "application" {
  description = "Application that will use the cache"
}

variable "organization" {
  description = "Organization the VPC is for."
}

variable "environment" {
  description = "Environment the VPC is for."
  default     = ""
}

/**
 * AMI Snapshot
 */

resource "aws_ami_from_instance" "main" {
  name                    = "${var.organization}-${var.environment}-${var.application}-ami-snapshot"
  source_instance_id      = "${var.source_instance_id}"
  snapshot_without_reboot = "${var.snapshot_without_reboot}"

  tags {
    Name         = "${var.environment == "" ? var.organization : format("%s-%s", var.organization, var.environment)}-ami"
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

output "ami_id" {
  value = "${aws_ami_from_instance.main.id}"
}
