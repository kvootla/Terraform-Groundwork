/**
 * Input
 */

variable "name" {
  description = "Used to populate the name tag for the bucket"
}

variable "account_id" {
  description = "Used to populate the name tag for the bucket"
}

variable "user_name" {
  description = "Used to populate the name tag for the bucket"
}

variable "environment" {
  description = "Environment tag, e.g prod"
}

variable "organization" {
  description = "Organization tag e.g. dchbx"
}

variable "application" {
  description = "Application tag e.g. enroll"
}


/**
 * Bucket
 */

resource "aws_s3_bucket" "bucket" {
  bucket        = "${var.name}"
  acl           = "private"

 versioning {
    enabled = false
  }

 tags {
    Name         = "${format("%s-%s-%s", var.organization, var.environment, var.application)}-i"
    Organization = "${var.organization}"
    Terraform    = "true"
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
                "AWS": "arn:aws:iam::${var.account_id}:user:${var.user_name}"
            },
            "Action": [
                "s3:DeleteObject",
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": "arn:aws:s3:::${var.name}/*"
        }
    ]
EOF
}
