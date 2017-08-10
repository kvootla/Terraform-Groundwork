/*
 * Inputs
 */

variable "region" {}
variable "account_id" {}
variable "ebs_vol_a_id" {}

/**
 * CloudWatch Event Target
 */

resource "aws_cloudwatch_event_target" "ebs_vol_a" {
target_id = "ebs_vol_a"
rule = "${aws_cloudwatch_event_rule.snap_ebs.name}"
arn = "arn:aws:automation:${var.region}:${var.account_id}:action/EBSCreateSnapshot/EBSCreateSnapshot_ebs_vol_a"
input = "\"arn:aws:ec2:${var.region}:${var.account_id}:volume/vol-${var.ebs_vol_a_id}\""
}
resource "aws_cloudwatch_event_rule" "snap_ebs" {
name = "snap-ebs-volumes"
description = "Snapshot EBS volumes"
schedule_expression = "cron(0 20 * * ? *)"
}
