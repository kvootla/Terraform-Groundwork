/**
 * Input
 */

variable "name" {
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
}
