/**
 * Inputs
 */

variable "bucket_name" {
  description = "S3 bucket name to store CloudTrail logs."
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
 * Cloudtrail
 */

resource "aws_cloudtrail" "main" {
  name                          = "${var.organization}-${var.environment}-${var.application}-trail"
  s3_bucket_name                = "${var.bucket_name}"
  s3_key_prefix                 = "cloudtrail"
  include_global_service_events = false

  tags {
    Name         = "${format("%s-%s-%s", var.organization, var.environment, var.application)}-trail"
    Organization = "${var.organization}"
    Terraform    = "true"
  }
}

/**
 * Outputs
 */

output "cloudtrail" {
  value = "${aws_cloudtrail.main.id}"
}
