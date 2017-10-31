Module: AWS/SNS Topic
=====================

A Terraform module for creating SNS Topic.

Module Input Variables
----------------------
- `name` - (Required) The friendly name of the topic to match.

Usage
-----

```hcl
module "sns_topic" {
 source = "github.com/kvootla/Terraform-Groundwork//tf-aws-sns/sns_topic"

  name = "${var.name}"
}
```

Outputs
=======

- `arn` - Set to the ARN of the found topic, suitable for referencing in other resources that support SNS topics
