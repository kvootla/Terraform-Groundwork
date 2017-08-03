
variable "internal" {
  description = "Determines if the ELB is internal or not"
  default     = false
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type = "list"
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type = "list"
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
 * Elastic Load Balancer/http
 */

resource "aws_elb" "main_elb" {
  internal           = "${internal}"
  subnet_ids                   = ["${split(",", var.subnet_ids)}"]
  security_group_ids         = ["${split(",",var.security_group_ids)}"]

  idle_timeout                = 30
  connection_draining         = true
  connection_draining_timeout = 15


 listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "${backend_port}"
    instance_protocol = "${backend_protocol}"
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
