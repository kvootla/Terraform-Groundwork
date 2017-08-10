/*
 * Inputs
 */

variable "arn" {}

variable "instance_id" {
  description = "List of security group IDs"
}

/**
 * CloudWatch Event Target
 */

resource "aws_cloudwatch_event_target" "main" {
  target_id = "main"
  rule      = "${aws_cloudwatch_event_rule.console.name}"
  arn       = "${var.arn}"
  values    = ["${var.instance_id}"]
}

resource "aws_cloudwatch_event_rule" "console" {
  name        = "capture-ec2-scaling-events"
  description = "Capture all EC2 scaling events"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.autoscaling"
  ],
  "detail-type": [
    "EC2 Instance Launch Successful",
    "EC2 Instance Terminate Successful",
    "EC2 Instance Launch Unsuccessful",
    "EC2 Instance Terminate Unsuccessful"
  ]
}
PATTERN
}

/**
 * Outputs
 */

output "cloudwatch_id" {
  value = "${aws_cloudwatch_event_target.main.id}"
}
