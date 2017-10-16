Module: AWS/cloudtrail
======================

A Terraform module for creating cloudtrail.

Module Input Variables
----------------------
- `name` - (Required) Specifies the name of the trail.
- `s3_bucket_name` - (Required) Specifies the name of the S3 bucket designated for publishing log files.
- `s3_key_prefix` - (Optional) Specifies the S3 key prefix that precedes the name of the bucket you have designated for log file delivery.
- `include_global_service_events` - (Optional) Specifies whether the trail is publishing events from global services such as IAM to the log files. Defaults to true.

Usage
-----

```hcl
module "cloudtrail" {
  source = "github.com/kvootla/Terraform-Groundwork//tf-aws-cloudtrail"

  bucket_name  = "${var.bucket_name}"
  application  = "enroll"
  environment  = "prod"
  organization = "mhc"
}
```

Outputs
=======

- `id` - The name of the trail
- `arn` - The Amazon Resource Name of the trail
