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

variable "instance_ids" {
  description = "List of instance IDs"
  default     = []
}

variable "security_group_id" {
  description = "List of security group IDs"
}

variable "connection_draining" {
  description = "Enable connection draining"
  default     = true
}

variable "connection_draining_timeout" {
  description = "Enable connection draining timeout period (in seconds)"
  default     = 300
}

variable "idle_timeout" {
  description = "Idle timeout period (in seconds)"
  default     = 60
}

variable "cross_zone_load_balancing" {
  description = "Enable cross zone load balancing"
  default     = true
}

variable "http_backend_port" {
  description = "Backend instance port for the http listener"
  default     = 80
}

variable "http_backend_protocol" {
  description = "Backend protocol for the http listener"
  default     = "http"
}

variable "https_backend_port" {
  description = "Backend instance port for the https listener"
  default     = 443
}

variable "https_backend_protocol" {
  description = "Backend protocol for the https listener"
  default     = "https"
}

variable "healthy_threshold" {
  description = "Healthy threshold"
  default     = 2
}

variable "unhealthy_threshold" {
  description = "Unhealthy threshold"
  default     = 2
}

variable "health_check_timeout" {
  description = "Healthcheck timeout (in seconds)"
  default     = 5
}

variable "health_check_interval" {
  description = "Healthcheck interval (in seconds)"
  default     = 10
}

variable "health_check_target" {
  description = "Healthcheck path"
  default     = "TCP:443/"
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
  name            = "${var.organization}-${var.environment}-${var.application}-elb"
  internal        = "${var.internal}"
  subnets         = ["${var.subnet_group_a1}", "${var.subnet_group_a2}"]
  instances       = ["${var.instance_ids}"]
  security_groups = ["${var.security_group_id}"]

  idle_timeout                = "${var.idle_timeout}"
  connection_draining         = "${var.connection_draining}"
  connection_draining_timeout = "${var.connection_draining_timeout}"
  cross_zone_load_balancing   = "${var.cross_zone_load_balancing}"

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "${var.http_backend_port}"
    instance_protocol = "${var.http_backend_protocol}"
  }

  listener {
    lb_port           = 443
    lb_protocol       = "https"
    instance_port     = "${var.https_backend_port}"
    instance_protocol = "${var.https_backend_protocol}"
  }

  health_check {
    healthy_threshold   = "${var.healthy_threshold}"
    unhealthy_threshold = "${var.unhealthy_threshold}"
    timeout             = "${var.health_check_timeout}"
    target              = "${var.health_check_target}"
    interval            = "${var.health_check_interval}"
  }

  tags {
    Name         = "${format("%s-%s-%s", var.organization, var.environment, var.application)}-elb"
    Organization = "${var.organization}"
    Terraform    = "true"
  }
}

/**
 * Outputs
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
