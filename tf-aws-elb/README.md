Module: AWS/Elastic Load Balancer
=================================

A Terraform module for creating an ELB with just HTTP/HTTPS support


Module Input Variables
----------------------

- `internal`     			- Determines if the ELB is internal or not
- `subnet_ids`          		- The VPC subnet ID for AZ1
- `instance_ids` 			- List of instance IDs
- `security_group_id`			- List of security group IDs
- `connection_draining` 	    	- Enable connection draining
- `connection_draining_timeout` 	- Enable connection draining timeout period (in seconds)
- `idle_timeout` 			- Idle timeout period (in seconds)
- `cross_zone_load_balancing`   	- Enable cross zone load balancing
- `http_backend_port` 			- Backend instance port for the http listener
- `http_backend_protocol` 		- Backend protocol for the http listener
- `https_backend_portBackend` 		- instance port for the https listener
- `https_backend_protocol` 		- Backend protocol for the https listener
- `healthy_threshold` 			- Healthy threshold
- `unhealthy_threshold` 		- Unhealthy threshold
- `health_check_timeout` 		- Healthcheck timeout (in seconds)
- `health_check_interval` 		- Healthcheck interval (in seconds)
- `health_check_target` 		- Healthcheck path
- `application` 	                - Application that will use the cache
- `organization`         		- organization for whom the VPC will be used (lowercase abbreviations)
- `environment`          		- environment, e.g. prod, preprod, etc. (optional - default: true

Usage
-----

```hcl
  module "web" {
  source              = "github.com/kvootla/Terraform-Groundwork//tf-aws-elb"

  internal            = "${var.internal}"
  subnets             = ["${var.subnet_group_a1}", "${var.subnet_group_a2}"]
  instances           = ["${var.instance_ids}"]
  security_groups     = ["${var.security_group_id}"]
  idle_timeout        = "${var.idle_timeout}"
  instance_port       = "${var.http_backend_port}"
  instance_protocol   = "${var.http_backend_protocol}"
  instance_port       = "${var.https_backend_port}"
  instance_protocol   = "${var.https_backend_protocol}"
  organization        = "dchbx"
  environment         = "prod"
}
```

Outputs
=======

- `elb_id`       - ELB ID
- `elb_name`     - ELB Name
- `elb_dns_name` - ELB DNS Name
