Module: AWS/S3
===============

This Terraform module creates an S3 bucket as well as an IAM user and key with access to the bucket.


Module Input Variables
----------------------

 - `name` - S3 Bucket name. 
This name will also be used to create the IAM user.

Usage
-----

```hcl
module "s3" {
  source               = "github.com/kvootla/Terraform-Groundwork//tf-aws-s3-bucket"

  name = "S3-bucket-name"
}
```
Outputs
=======

 - iam_access_key_id     - IAM access key
 - iam_access_key_secret - IAM access secret
