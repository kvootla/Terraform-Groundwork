/**
 * Input Variables
 */

variable "name" { default = "igw" }
variable "vpc_id" {}


/**
 * Internet Gateway
 */

resource "aws_internet_gateway" "igw" {
  vpc_id = "${var.vpc_id}"
     tags { Name = "${var.name}" }
}


/**
 * Outputs Varibales
 */

output "igw_id" { 
	value = "${aws_internet_gateway.igw.id}"
    }
