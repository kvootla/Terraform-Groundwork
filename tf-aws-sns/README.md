Module: AWS/SNS Topic Resources 
===============================

A Terraform module for creating SNS Topic Resources.

Module Input Variables
----------------------
- `name` - (Required) The friendly name of the topic to match.
- `topic_arn` - (Required) The ARN of the SNS topic to subscribe to
- `protocol` - (Required) The protocol to use. The possible values for this are: sqs, lambda, application. (http or https are partially supported, see below) (email, sms, are options but unsupported, see below).
- `endpoint` - (Required) The endpoint to send data to, the contents will vary with the protocol. (see below for more information)

Usage
-----

```hcl
module "sns_topic" {
 source = "github.com/kvootla/Terraform-Groundwork//tf-aws-sns"

}
```

Outputs
=======

- `id` - The ARN of the subscription
- `topic_arn` - The ARN of the topic the subscription belongs to
