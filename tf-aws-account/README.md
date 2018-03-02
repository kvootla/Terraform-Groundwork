Module: AWS/IAM Account 
=======================

A Terraform module for managing Account & Password Policy.

Module Input Variables
----------------------
- `allow_users_to_change_password` - Whether to allow users to change their own password
- `hard_expiry` - Whether users are prevented from setting a new password after their password has expired (i.e. require administrator reset)
- `max_password_age` - The number of days that an user password is valid.
- `minimum_password_length` - Minimum length to require for user passwords.
- `password_reuse_prevention` - The number of previous passwords that users are prevented from reusing.
- `require_lowercase_characters` - Whether to require lowercase characters for user passwords.
- `require_numbers` - Whether to require numbers for user passwords.
- `require_symbols` - Whether to require symbols for user passwords.
- `require_uppercase_characters` - Whether to require uppercase characters for user passwords.

Usage
-----

```hcl
module "aws_iam_account_password_policy" {
  source              		 = "github.com/kvootla/Terraform-Groundwork//tf-aws-account"

  minimum_password_length        = "${var.minimum_length}"
  require_lowercase_characters   = "${var.require_lowercase}"
  require_uppercase_characters   = "${var.require_uppercase}"
  require_numbers                = "${var.require_numbers}"
  require_symbols                = "${var.require_symbols}"
  allow_users_to_change_password = "${var.allow_user_change}"
  hard_expiry                    = "${var.hard_expiry}"
  max_password_age               = "${var.maximum_age}"
  password_reuse_prevention      = "${var.reuse_history}"
}
```
