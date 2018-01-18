Module: AWS/IAM Account 
=======================

A Terraform module for IAM Account Alias data source allows access to the account alias for the effective account.

Module Input Variables
----------------------
- `account_name` - The name of the account.
- `password_min_length` - The minimal length of passwords.
- `password_reuse_prevention` - Prevent reuse of the given amount of passwords.
- `password_hard_expiry` - Requires administrative reset of the user after expiring.
- `password_max_age` - The maximum age before a password will expire.
- `trail_name` - Name of the cloudtrail trail.
- `trail_bucketname` -  Name of the cloudtrail bucket. Will defaults to <account-id>-logs.
- `trail_bucketname_create` - Defines if the bucket should be created.


Usage
-----

```hcl
resource "aws_iam_account_password_policy" "main" {
  minimum_password_length        = "${var.password_min_length}"
  require_uppercase_characters   = true
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  allow_users_to_change_password = true
  password_reuse_prevention      = "${var.password_reuse_prevention}"
  hard_expiry                    = "${var.password_hard_expiry}"
  max_password_age               = "${var.password_max_age}"
}
```
