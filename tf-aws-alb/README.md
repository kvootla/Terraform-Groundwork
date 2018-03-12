Module: AWS/Application Load Balancer
=====================================

A Terraform module for creating an ALB with just HTTP/HTTPS support

Module Input Variables
----------------------
- `internal` - Determines if the ALB is externally facing or internal. (Optional; default: false)
- `name` - Name of the ALB as it appears in the AWS console. (Optional; default: my-alb)
- `protocols` - A comma delimited list of protocols the ALB will accept for incoming connections. O
- `security_groups` - A comma delimited list of security groups to attach to the ALB. (Required)
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
- `application` - Application that will use the cache (lowercase abbreviations)
- `organization` - Organization the ALB is for (lowercase abbreviations)
- `environment` - Environment the ALB is for (lowercase abbreviations)

Usage
-----

```hcl
module "alb" {
  source              = "github.com/kvootla/Terraform-Groundwork//tf_aws_alb"

  name                = "alb-${var.organization}-${var.environment}-${var.application}"
  subnets             = ["${var.subnet_group}"]
  security_groups     = ["${var.security_group_id}"]
  internal            = "${var.internal}"
  port                = "${var.backend_port}"
  protocol            = "${upper(var.backend_protocol)}"
  vpc_id              = "${var.vpc_id}"
  interval            = "${var.health_check_interval}"
  healthy_threshold   = "${var.healthy_threshold}"
  unhealthy_threshold = "${var.unhealthy_threshold}"
  timeout             = "${var.health_check_timeout}"
  protocol            = "${var.backend_protocol}"
  path                = "${var.health_check_path}"
  port                = "${var.port}"
  load_balancer_arn   = "${aws_alb.alb_nologing.arn}"
  target_group_arn    = "${aws_alb_target_group.target_group.id}"
  }
```

Outputs
=======

- `id` - `id` of the ALB created
- `dns_name` - DNS CNAME of the ALB created
- `zone_id` - Route53 `zone_id` of the newly minted ALB
- `target_group_arn` - `arn` of the target group. Useful for passing to your Auto Scaling group module
