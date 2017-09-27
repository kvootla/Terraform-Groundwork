Module: AWS/Application Load Balancer
=====================================

A Terraform module for creating an ALB with just HTTP/HTTPS support

Module Input Variables
----------------------
- `alb_is_internal` - Determines if the ALB is externally facing or internal. (Optional; default: false)
- `alb_name` - Name of the ALB as it appears in the AWS console. (Optional; default: my-alb)
- `alb_protocols` - A comma delimited list of protocols the ALB will accept for incoming connections. O
- `alb_security_groups` - A comma delimited list of security groups to attach to the ALB. (Required)
- `aws_region` - Region to deploy our resources. (Required)
- `aws_account_id` - The AWS account ID. (Required)
- `backend_port` - Port on which the backing instances serve traffic. (Optional; default: 80)
- `backend_protocol` - Protocol the backing instances use. (Optional; default: HTTP)
- `certificate_arn` - . (Required if using HTTPS in `alb_protocols`)
- `cookie_duration` - If sticky sessions via cookies are desired, set this variable to a value from 2 - 604800 seconds. (Optional)
- `health_check_path` - Path for the load balancer to health check instances. (Optional; default: /)
- `log_bucket` - S3 bucket where access logs should land. (Required)
- `log_prefix` - S3 prefix within the `log_bucket` where logs should land. (Optional)
- `principle_account_id` - A mapping of regions to principle account IDs used to send LB logs. (Should only change as regions are added)
- `subnets` - ALB will be created in the subnets in this list. (Required)
- `vpc_id` - Resources will be created in the VPC with this `id`. (Required)

Usage
-----

```hcl
module "alb" {
  source              = "github.com/kvootla/Terraform-Groundwork//tf_aws_alb"
  alb_security_groups = "${var.alb_security_groups}"
  aws_account_id      = "${var.aws_account_id}"
  certificate_arn     = "${var.certificate_arn}"
  log_bucket          = "${var.log_bucket}"
  log_prefix          = "${var.log_prefix}"
  subnets             = "${var.public_subnets}"
  vpc_id              = "${var.vpc_id}"
  }
```

Outputs
=======

- `alb_id` - `id` of the ALB created.
- `alb_dns_name` - DNS CNAME of the ALB created.
- `alb_zone_id` - Route53 `zone_id` of the newly minted ALB.
- `target_group_arn` - `arn` of the target group. Useful for passing to your Auto Scaling group module.
- `principle_account_id` - the id of the AWS root user within this region.
