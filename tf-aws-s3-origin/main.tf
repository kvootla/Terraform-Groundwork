/**
 * Inputs
 */

variable "bucket_name" {}
variable "logs_bucket_name" {}

variable "cors_allowed_headers" {
  default = ["Authorization"]
}

variable "cors_allowed_methods" {
  default = ["GET"]
}

variable "cors_allowed_origins" {
  default = ["*"]
}

variable "cors_expose_headers" {
  default = []
}

variable "cors_max_age_seconds" {
  default = "3000"
}

variable "region" {
  default = "us-east-1"
}

variable "project" {
  default = "Unknown"
}

variable "environment" {
  default = "Unknown"
}

/**
 * Application Load Balancer
 */

#
# S3 resources
#
data "aws_iam_policy_document" "read_only_bucket_policy" {
  policy_id = "S3AnonymousReadOnlyPolicy"

  statement {
    sid = "S3ReadOnly"

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["s3:GetObject"]

    resources = [
      "arn:aws:s3:::${var.bucket_name}/*",
    ]
  }
}

resource "aws_s3_bucket" "site_bucket" {
  bucket = "${var.bucket_name}"
  policy = "${data.aws_iam_policy_document.read_only_bucket_policy.json}"
  region = "${var.region}"

  cors_rule {
    allowed_headers = "${var.cors_allowed_headers}"
    allowed_methods = "${var.cors_allowed_methods}"
    allowed_origins = "${var.cors_allowed_origins}"
    expose_headers  = "${var.cors_expose_headers}"
    max_age_seconds = "${var.cors_max_age_seconds}"
  }

  tags {
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
}

resource "aws_s3_bucket" "access_logs_bucket" {
  bucket = "${var.logs_bucket_name}"
  acl    = "log-delivery-write"
  region = "${var.region}"

  tags {
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
}

/**
 * Outputs
 */

output "site_bucket" {
  value = "${aws_s3_bucket.site_bucket.id}"
}

output "logs_bucket" {
  value = "${aws_s3_bucket.access_logs_bucket.id}"
}
