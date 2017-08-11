/**
 * Inputs
 */

variable "engine" {
  description = "Caching engine (e.g. redis, memcached, etc.)"
}

variable "engine_version" {
  description = "Caching engine version"
}

variable "node_type" {
  description = "Node type (instance size)"
}

variable "node_number" {
  description = "Number of nodes"
}

variable "port" {
  description = "Port"
}

variable "parameter_group_name" {
  description = "Parameter group Name"
}

variable "security_group_ids" {
  description = "Security group IDs"
  type        = "list"
}

variable "apply_immediately" {
  description = "Immediately apply changes"
  default     = true
}

variable "subnet_group_subnet_ids" {
  description = "Subnet group subnet IDs"
  type        = "list"
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
 * Elasticache Subnet Group
 */

resource "aws_elasticache_subnet_group" "main" {
  name       = "${var.organization}-${var.environment}-${var.engine}-${var.application}-sbngrp"
  subnet_ids = ["${var.subnet_group_subnet_ids}"]
}

/**
* Elasticache Cluster
*/

resource "aws_elasticache_cluster" "main" {
  cluster_id           = "${var.environment}-${var.engine}-${var.application}"
  engine               = "${var.engine}"
  engine_version       = "${var.engine_version}"
  node_type            = "${var.node_type}"
  port                 = "${var.port}"
  num_cache_nodes      = "${var.node_number}"
  parameter_group_name = "${var.parameter_group_name}"
  security_group_ids   = ["${var.security_group_ids}"]
  subnet_group_name    = "${aws_elasticache_subnet_group.main.name}"
  apply_immediately    = "${var.apply_immediately}"

  tags {
    Name         = "${var.organization}-${var.environment}-${var.engine}-${var.application}-elasticache"
    Organization = "${var.organization}"
    Terraform    = "true"
  }
}

/**
* Outputs
*/

output "elasticache_cluster_id" {
  value = "${aws_elasticache_cluster.main.id}"
}

output "port" {
  value = "6379"
}

output "endpoint" {
  value = "${aws_elasticache_cluster.main.primary_endpoint_address}"
}
