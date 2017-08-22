Module: AWS/Elasticache
=======================

A Terraform module to represents an AWS ElastiCache Redis cluster. 


Module Input Variables
----------------------

- `cluster_id` - ID of the cluster
- `vpc_id` - ID of VPC meant to house the cache
- `private_subnet_ids` - Comma delimited list of private subnet IDs
- `engine_version` - Cache engine version (default: `2.8.24`)
- `instance_type` - Instance type for cache instance (default: `cache.m3.medium`)
- `maintenance_window` - 60 minute time window to reserve for maintenance

Usage
-----

```hcl
module "elasticache_redis" {
  source               = "github.com/kvootla/Terraform-Groundwork//tf-aws-elasticache"

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
}
```

Outputs
=======

- `cache_security_group_id` - Security group ID of the cache cluster
- `hostname` - Public DNS name of cache node
- `port` - Port of cache instance
