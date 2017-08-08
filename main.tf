/**
 * Inputs
 */

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
 * Simple Notification Services/Topic
 */

resource "aws_sns_topic" "main" {
   name            = "sns-${var.organization}-${var.environment}-${var.application}"
}

/**
 * Outputs
 */

output "sns_id" {
    value = "${aws_sns_topic.main.id}"
}

