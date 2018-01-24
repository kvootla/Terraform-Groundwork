Module: AWS/S3 Bucket
=====================

This Terraform module creates an S3 bucket as well as an IAM user and key with access to the bucket.


Module Input Variables
----------------------

- `name` - S3 Bucket name. This name will also be used to create the IAM user.

Usage
-----

```hcl
module "s3" {
  source  = "github.com/kvootla/Terraform-Groundwork//tf-aws-s3-bucket"
  name    = "S3-bucket-name"
}
```
Outputs
=======

- `id` - The name of the bucket
- `arn` - The ARN of the bucket. Will be of format arn:aws:s3:::bucketname
- `bucket_domain_name` - The bucket domain name. Will be of format bucketname.s3.amazonaws.com
