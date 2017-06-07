/**
 * Input Variables
 */

variable "elb_name" {}

variable "elb_is_internal" {
  description = "Determines if the ELB is internal or not"
  default     = false
}

variable "elb_security_group" {}

variable "ssl_certificate_id" {
  description = "The ARN of the SSL Certificate in EC2"
}

variable "subnet_az1" {
  description = "The subnet for AZ1"
}

variable "subnet_az2" {
  description = "The subnet for AZ2"
}

variable "backend_port" {
  description = "The port the service on the EC2 instances listens on"
}

variable "backend_protocol" {
  description = "The protocol the backend service speaks"
}

variable "health_check_target" {
  description = "The URL the ELB should use for health checks"
}

/**
 * Elstic Load Balancer/https
 */

resource "aws_elb" "elb" {
  name            = "${var.elb_name}"
  subnets         = ["${var.subnet_az1}", "${var.subnet_az2}"]
  internal        = "${var.elb_is_internal}"
  security_groups = ["${var.elb_security_group}"]

  listener {
    instance_port      = "${var.backend_port}"
    instance_protocol  = "${var.backend_protocol}"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "${var.ssl_certificate_id}"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "${var.health_check_target}"
    interval            = 30
  }

  cross_zone_load_balancing = true
}

/**
 * Outputs Varibales
 */

output "elb_id" {
  value = "${aws_elb.elb.id}"
}

output "elb_name" {
  value = "${aws_elb.elb.name}"
}

output "elb_dns_name" {
  value = "${aws_elb.elb.dns_name}"
}
