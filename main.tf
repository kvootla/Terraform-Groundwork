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

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Id": "Policy1439656804052",
    "Statement": [
        {
            "Sid": "Stmt1439656798784",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::"${var.account_id}":"${var.user_name}""
            },
            "Action": [
                "s3:DeleteObject",
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": "arn:aws:s3:::"${var.name}"/*"
        }
    ]
EOF
}

/**
 * Outputs
 */

output "bucket_id" {
  value = "${aws_s3_bucket.bucket.id}"
}

