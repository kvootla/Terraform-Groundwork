/**
 * Inputs
 */

variable "delay_seconds" {
  description = "The time in seconds that the delivery of all messages in the queue will be delayed."
  default     = "90"
}

variable "max_message_size" {
  description = "The time in seconds that the delivery of all messages in the queue will be delayed."
  default     = "2048"
}

variable "redrive_policy" {
  description = "The JSON policy to set up the Dead Letter Queue"
  default     = ""
}

variable "application" {
  description = "Application that will use the cache"
}

variable "organization" {
  description = "Organization the SQS is for."
}

variable "environment" {
  description = "Environment the SQS is for."
  default     = ""
}

/**
 * Simple Queue Service
 */

resource "aws_sqs_queue" "main" {
  name             = "${var.organization}-${var.environment}-${var.application}-sqs"
  delay_seconds    = "${var.delay_seconds}"
  max_message_size = "${var.max_message_size}"
  redrive_policy   = "${var.redrive_policy}"
}

/**
 * Outputs
 */

output "url" {
  value = "${aws_sqs_queue.main.id}"
}

output "arn" {
  value = "${aws_sqs_queue.main.arn}"
}
