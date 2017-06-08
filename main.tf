/**
 * Input Variables
 */

variable "name" { default = "igw" }
variable "vpc_id" {}
variable "environment" {
  description = "Environment tag, e.g prod"
}

/**
 * Internet Gateway
 */

resource "aws_internet_gateway" "igw" {
  vpc_id = "${var.vpc_id}"
  tags { Name = "${var.name}" }
      Environment = "${var.environment}"
      Terraform    = "true"
}


/**
 * Outputs Varibales
 */

output "igw_id" { 
	value = "${aws_internet_gateway.igw.id}"
    }
