Module: AWS/SNS Topic Subscription
==================================

A Terraform module for creating SNS Topic Subscription.

Module Input Variables
----------------------
- `topic_arn` - (Required) The ARN of the SNS topic to subscribe to
- `protocol` - (Required) The protocol to use. The possible values for this are: sqs, lambda, application. (http or https are partially supported, see below) (email, sms, are options but unsupported, see below).
- `endpoint` - (Required) The endpoint to send data to, the contents will vary with the protocol. (see below for more information)

Usage
-----

```hcl
module "sns_topic_subscription" {
 source = "github.com/kvootla/Terraform-Groundwork//tf-aws-sns/sns_topic_subscription"

  topic_arn = "${var.topic_arn}"
  protocol  = "${var.protocol}"
  endpoint  = "${var.endpoint}"
}
```

Outputs
=======

- `id` - The ARN of the subscription
- `topic_arn` - The ARN of the topic the subscription belongs to
