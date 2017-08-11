/**
 * Inputs
 */

variable "region" {
  description = "The region of the EBS volume to be snapshot"
  default     = "us-east-1"
}

variable "account_id" {
  description = "The canonical user ID associated with the aws account"
}

variable "ebs_volume_id" {
  description = "EBS volume ID for capturing the snapshot"
}

variable "cron_expression" {
  description = "Scheduling expression to capture snapshot at certain interval"
  default     = "cron(0 20 * * ? *)"
}

variable "target_id" {
  description = "unique target assignment ID to be assigned if needed"
  default     = "main"
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
 * CloudWatch Event Target
 */

resource "aws_cloudwatch_event_target" "main" {
  target_id = "${var.target_id}"
  rule      = "${aws_cloudwatch_event_rule.snap_ebs.name}"
  arn       = "arn:aws:automation:${var.region}:${var.account_id}:action/EBSCreateSnapshot/EBSCreateSnapshot_ebs_volume"
  input     = "\"arn:aws:ec2:${var.region}:${var.account_id}:volume/vol-${var.ebs_volume_id}\""
}

resource "aws_cloudwatch_event_rule" "snap_ebs" {
  name                = "${var.organization}-${var.environment}-${var.application}-ebs"
  schedule_expression = "${var.cron_expression}"
}

/**
 * Outputs
 */

output "arn" {
  value = "${aws_cloudwatch_event_target.main.arn}"
}
