Module: AWS/SQS Queue
=====================

A Terraform module for creating SQS Queue.

Module Input Variables
----------------------
- `name` - (Optional) This is the human-readable name of the queue. If omitted, Terraform will assign a random name.
name_prefix - (Optional) Creates a unique name beginning with the specified prefix. Conflicts with name.
- `message_retention_seconds` - (Optional) The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days). The default for this attribute is 345600 (4 days).
- `max_message_size` - (Optional) The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB). The default for this attribute is 262144 (256 KiB).
- `delay_seconds` - (Optional) The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes). The default for this attribute is 0 seconds.
- `redrive_policy` - (Optional) The JSON policy to set up the Dead Letter Queue, see AWS docs. Note: when specifying maxReceiveCount, you must specify it as an integer (5), and not a string ("5").

Usage
-----

```hcl
module "aws_sqs_queue" {
  source    = "github.com/kvootla/Terraform-Groundwork//tf-aws-sqs"
  
  delay_seconds    = "${var.delay_seconds}"
  max_message_size = "${var.max_message_size}"
  redrive_policy   = "${var.redrive_policy}"

  application = "enroll"
  environment  = "prod"
  organization = "mhc"
}
```

Outputs
=======

- `id` - The URL for the created Amazon SQS queue
- `arn` - The ARN of the SQS queue
