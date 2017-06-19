/**
 * Input
 */

variable "name" {
  description = "Used to populate the name tag for the bucket"
}

variable "account_id" {
  description = "Used to get access for the bucket"
}

variable "user_name" {
  description = "Used to get the access permission for the bucket"
}

/**
 * S3 Bucket
 */

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.name}"
  acl    = "private"

  versioning {
    enabled = false
  }
 }

/**
 * Outputs
 */

output "bucket_id" {
  value = "${aws_s3_bucket.bucket.id}"
}
