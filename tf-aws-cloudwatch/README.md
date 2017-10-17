Module: AWS/Cloudwatch
======================

A Terraform module for creating cloudwatch.

Module Input Variables
----------------------
- `target_id` - The unique target assignment ID. If missing, will generate a random, unique id.
- `ebs_volume_id` - EBS volume ID for capturing the snapshot
- `cron_expression` - (Required, if event_pattern isn't specified) The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes).

Usage
-----

```hcl
module "cloudwatch" {
  source = "github.com/kvootla/Terraform-Groundwork//tf-aws-cloudwatch"

  ebs_volume_id = "${var.ebs_volume_id}"
  target_id = "${var.target_id}"

  application = "enroll"
  environment  = "prod"
  organization = "mhc"
}
```

Outputs
=======

- `arn` - The Amazon Resource Name (ARN) of the rule.
