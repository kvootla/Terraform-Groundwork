/**
 * Input Variables
 */

variable "cidrs" {}

variable "vpc_id" {}

variable "availability_zones" {
  description = "A list of availability zones inside the VPC"
}

variable "enable_dns_hostnames" {
  description = "True to use private DNS within the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "True to use private DNS within the VPC"
  default     = true
}

variable "private_propagating_vgws" {
  description = "A list of VGWs the private route table should propagate."
  default     = []
}

variable "private_subnets" {
  default = "A list of public subnets inside the VPC"
}

variable "map_public_ip_on_launch" {
  description = "True to auto-assign public IP on launch"
  default     = true
}

variable "public_propagating_vgws" {
  description = "A list of VGWs the public route table should propagate."
  default     = []
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
}

variable "organization" {}

variable "environment" {}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}

  
/**
 * Subnets
 */

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${var.vpc_id}"
  cidrs                   = "${var.public_subnets}"
  availability_zone       = "${var.availability_zones}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"

  lifecycle {
    create_before_destroy = true
  }


  tags {
    Name         = "${var.environment == "" ? var.organization : format("%s-%s", var.organization, var.environment)}-subnet"
    Organization = "${var.organization}"
    Terraform    = "true"
  }
}


/**
 * Outputs Varibales
 */


output "public_subnet_cidrs" {
  value = ["${aws_subnet.public_subnet.*.cidrs}"]
}

output "public_subnet_ids" {
  value = ["${aws_subnet.public_subnet.*.id}"]
}
