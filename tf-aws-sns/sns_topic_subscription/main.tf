/**
 * Inputs
 */

variable "topic_arn" {
  description = "The ARN of the SNS topic to subscribe"
}

variable "protocol" {
  description = "The possible values for protocol are sqs, lambda, application"
}

variable "endpoint" {
  description = "The endpoint to send data to, the contents will vary with the protocol"
}

/**
 * Simple Notification Services/Topic Subscription
 */

resource "aws_sns_topic_subscription" "main" {
  topic_arn = "${var.topic_arn}"
  protocol  = "${var.protocol}"
  endpoint  = "${var.endpoint}"
}

/**
 * Outputs
 */

output "sns_id" {
  value = "${aws_sns_topic.main.id}"
}

output "arn" {
  value = "${aws_sns_topic_subscription.main.outputs.ARN}"
}

