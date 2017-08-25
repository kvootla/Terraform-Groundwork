/**
 * Inputs
 */

variable "bucket_name" {
  description = "Used to populate the name tag for the bucket"
}

/**
 * S3 Bucket
 */

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}"
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
