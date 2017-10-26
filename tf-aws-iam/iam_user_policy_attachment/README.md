Module: AWS/IAM User Policy Attachment
======================================

A Terraform module for creating an IAM User Policy Attachment.

Module Input Variables
----------------------
- `user` - The user the policy should be applied.
- `policy_arn` - The ARN of the policy you want to apply.

Usage
-----

```hcl
module "aws_iam_user_policy_attachment" {
  source = "github.com/kvootla/Terraform-Groundwork//tf-aws-iam/iam_user_policy_attachment"
  
  user       = "${var.user}"
  policy_arn = "${var.policy_arn}"
}
```
