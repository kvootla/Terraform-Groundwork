variable "internal" {
  description = "Determines if the ELB is internal or not"
  default     = false
}

variable "subnet_az1" {
  description = "The subnet for AZ1"
}

variable "subnet_az2" {
  description = "The subnet for AZ2"
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
  internal          = "${var.internal}"
  subnets         = ["${var.subnet_az1}", "${var.subnet_az2}"]
  security_groups   = ["${var.security_group_id}"]

  idle_timeout                = 30
  connection_draining         = true
  connection_draining_timeout = 15

  listener {
    lb_port           = 80
    lb_protocol       = "http"
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

  cross_zone_load_balancing = true

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
