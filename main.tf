/**
 * Input Variables
 */

variable "internal" {
  description = "Determines if the ALB is internal. Default: false"
  default     = false
}

variable "log_bucket" {
  description = "S3 bucket for storing ALB access logs."
}

variable "log_prefix" {
  description = "S3 prefix within the log_bucket under which logs are stored."
}

variable "subnet_group_a1" {
  description = "The subnet for availability zone 1"
}

variable "subnet_group_a2" {
  description = "The subnet for availability zone 2"
}

variable "vpc_id" {
  description = "VPC id where the ALB and other resources will be deployed."
}

variable "security_group_id" {
  description = "List of security group IDs"
}

variable "alb_protocols" {
  description = "A comma delimited list of the protocols the ALB accepts."
  default     = "HTTPS"
}

variable "backend_port" {
  description = "The port the service on the EC2 instances listen on."
  default     = 80
}

variable "backend_protocol" {
  description = "The protocol the backend service speaks."
  default     = "HTTP"
}

variable "health_check_path" {
  description = "The URL the ELB should use for health checks."
  default     = "/"
}

variable "application" {
  description = "Application that will use the cache"
}

variable "organization" {
  description = "Organization the ALB is for."
}

variable "environment" {
  description = "Environment the ALB is for."
  default     = ""
}

/**
 * Application Load Balancer
 */

resource "aws_alb" "alb_loging" {
  name            = "alb-${var.organization}-${var.environment}-${var.application}"
  subnets         = ["${var.subnet_group_a1}", "${var.subnet_group_a2}"]
  security_groups = ["${var.security_group_ids}"]
  internal        = "${var.internal}"

  access_logs {
    bucket = "${var.log_bucket}"
    prefix = "${var.log_prefix}"
  }

  count = "${var.log_bucket != "" && var.log_prefix != "" ? 1 : 0}"
}

resource "aws_alb" "alb_nologing" {
  name            = "alb-${var.organization}-${var.environment}-${var.application}"
  subnets         = ["${var.subnet_group_a1}", "${var.subnet_group_a2}"]
  security_groups = ["${var.security_group_ids}"]
  internal        = "${var.internal}"

  access_logs {
    bucket = "${var.log_bucket}"
    prefix = "${var.log_prefix}"
  }

  count = "${(var.log_bucket == "" || var.log_prefix == "") ? 1 : 0}"

  tags {
    Name         = "${format("%s-%s-%s", var.organization, var.environment, var.application)}-elb"
    Organization = "${var.organization}"
    Terraform    = "true"
  }
}

resource "aws_alb_target_group" "target_group" {
  name     = "${var.alb_name}-tg"
  port     = "${var.backend_port}"
  protocol = "${upper(var.backend_protocol)}"
  vpc_id   = "${var.vpc_id}"

  health_check {
    interval            = 30
    path                = "${var.health_check_path}"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    protocol            = "${var.backend_protocol}"
  }

  tags {
    Name         = "${format("%s-%s-%s", var.organization, var.environment, var.application)}-elb"
    Organization = "${var.organization}"
    Terraform    = "true"
  }
}

resource "aws_alb_listener" "front_end_http" {
  load_balancer_arn = "${aws_alb.main.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.target_group.id}"
    type             = "forward"
  }

  count = "${trimspace(element(split(",", var.alb_protocols), 1)) == "HTTP" || trimspace(element(split(",", var.alb_protocols), 2)) == "HTTP" ? 1 : 0}"
}

resource "aws_alb_listener" "front_end_https" {
  load_balancer_arn = "${aws_alb.main.arn}"
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = "${var.certificate_arn}"
  ssl_policy        = "ELBSecurityPolicy-2015-05"

  default_action {
    target_group_arn = "${aws_alb_target_group.target_group.id}"
    type             = "forward"
  }

  count = "${trimspace(element(split(",", var.alb_protocols), 1)) == "HTTPS" || trimspace(element(split(",", var.alb_protocols), 2)) == "HTTPS" ? 1 : 0}"
}

/**
 * Outputs Varibales
 */

output "dns_name" {
  value = "${aws_alb.alb_loging.dns_name}"
}

output "id" {
  value = "${aws_alb.alb_loging.id}"
}

output "zone_id" {
  value = "${aws_alb.alb_loging.zone_id}"
}
