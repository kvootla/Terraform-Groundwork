/*
 * Inputs
 */

variable "internal" {
  description = "Determines if the ELB is internal or not"
  default     = false
}

variable "subnet_group_a1" {
  description = "The subnet for availability zone 1"
}

variable "subnet_group_a2" {
  description = "The subnet for availability zone 2"
}

variable "security_group_id" {
  description = "List of security group IDs"
}

variable "backend_port" {
  description = "Instance port"
}

variable "backend_protocol" {
  description = "Protocol to use, HTTP or TCP"
}

variable "health_check_target" {
  description = "Healthcheck path"
}

variable "application" {
  description = "Application that will use the cache"
}

variable "organization" {
  description = "Organization the VPC is for."
}

variable "environment" {
  description = "Environment the VPC is for."
  default     = ""
}

/**
 * Elastic Load Balancer
 */

resource "aws_elb" "main_elb" {
  name               = "${var.organization}-${var.environment}-${var.application}-elb"
  internal           = "${var.internal}"
  subnet_ids         = ["${var.subnet_ids}"]
  security_group_ids = ["${var.security_group_ids}"]

  idle_timeout                = 30
  connection_draining         = true
  connection_draining_timeout = 15
  cross_zone_load_balancing   = true

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "${var.backend_port}"
    instance_protocol = "${var.backend_protocol}"
  }

  listener {
    lb_port           = 443
    lb_protocol       = "https"
    instance_port     = "${var.backend_port}"
    instance_protocol = "${var.backend_protocol}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "${var.health_check_target}"
    interval            = 30
  }

  tags {
    Name         = "${format("%s-%s-%s", var.organization, var.environment, var.application)}-i"
    Organization = "${var.organization}"
    Terraform    = "true"
  }
}

/**
 * Outputs Varibales
 */

output "elb_id" {
  value = "${aws_elb.main_elb.id}"
}

output "elb_name" {
  value = "${aws_elb.main_elb.name}"
}

output "elb_dns_name" {
  value = "${aws_elb.main_elb.dns_name}"
}
