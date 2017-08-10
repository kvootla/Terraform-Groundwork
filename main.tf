/*
 * Inputs
 */

variable "name" {}
variable "arn" {}
variable "volume_id" {}
variable "cron_expression"

/**
 * CloudWatch Event Target
 */

resource "aws_cloudwatch_event_target" "main" {
 volume_id = "${var.volume_id}"
  arn       = "${var.arn}"
}

resource "aws_cloudwatch_schedule_rule" "console" {

cron_expression = "${var.cron_expression}"

  event_pattern = <<PATTERN
{
  "version": "0",
  "id": "89d1a02d-5ec7-412e-82f5-13505f849b41",
  "detail-type": "Scheduled Event",
  "source": "aws.events",
  "account": "123456789012",
  "time": "2016-12-30T18:44:49Z",
  "region": "us-east-1",
  "resources": [
    "arn:aws:events:us-east-1:123456789012:rule/SampleRule"
  ],
  "detail": {}
}
PATTERN
}

resource "aws_cloudwatch_event_rule" "console" {
  name        = "${var.name}"
  description = "Capture each ebs snapshots"

  event_pattern = <<PATTERN
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*",
        "ec2:RebootInstances",
        "ec2:StopInstances",
        "ec2:TerminateInstances",
        "ec2:CreateSnapshot"
      ],
      "Resource": "*"
    }
  ]
 }
}
PATTERN
}
