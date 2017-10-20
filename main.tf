/**
 * Inputs
 */

variable "vpc_id" {
  description = "The id of the VPC that the desired Route Table belongs too"
}

variable "service_name" {
  description = "The AWS service name of the specific VPC Endpoint to retrieve"
  default     = "com.amazonaws.us-east-1.s3"
}

variable "route_table_ids" {
  description = "The ID of the Route Table"
  type        = "list"
  default     = []
}

/**
 * Security Groups/RDP
 */

resource "aws_vpc_endpoint" "s3" {
  vpc_id          = "${var.vpc_id}"
  route_table_ids = ["${var.route_table_ids}"]
}

/**
 * Outputs
 */

output "endpoint_id" {
  value = "${aws_vpc_endpoint.s3.id}"
}
