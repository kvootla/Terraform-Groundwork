/**
 * Inputs
 */

variable "security_group_name" {
  description = "The name for the security group"
}

variable "vpc_id" {
  description = "The VPC this security group will go in"
}

variable "source_cidr_block" {
  description = "The source CIDR block to allow traffic from"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}


/**
 * Security Groups/Rabbitmq
 */

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
  }
   
resource "aws_security_group" "main_security_group" {
    name = "${var.security_group_name}"
    vpc_id = "${var.vpc_id}"


    // allow traffic for TCP 5671
    ingress {
        from_port = 5671
        to_port = 5671
        protocol = "tcp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }

    // allow traffic for TCP 5672
    ingress {
        from_port = 5672
        to_port = 5672
        protocol = "tcp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }
    
    // allow traffic for TCP 15671
    ingress {
        from_port = 15671
        to_port = 15671
        protocol = "tcp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }

    // allow traffic for TCP 15672
    ingress {
        from_port = 15672
        to_port = 15672
        protocol = "tcp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }
    
}



/**
 * Outputs
 */

output "security_group_id" {
  value = "${aws_security_group.main_security_group.id}"
}

