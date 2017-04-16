
/**
 * Inputs
 */

variable "instance_name" {
  description = "Used to populate the Name tag. This is done in main.tf"
}

variable "ami_id" {
  description = "The AMI to use"
}

variable "number_of_instances" {
  description = "number of instances"
  default = 1
}

variable "subnet_id" {
  description = "The VPC subnet the instance(s) will go in"
}

variable "instance_type" {}


variable "user_data" {
   description = "The path to a file with user_data for the instances"
}

variable "key_name" {}

variable "tags" {
  default = {
    created_by = "terraform"
 }
}


/**
 * EC2 Instances
 */

resource "aws_instance" "main" {
    ami		         = "${var.ami_id}"
    count	         = "${var.number_of_instances}"
    subnet_id	     = "${var.subnet_id}"
    instance_type  = "${var.instance_type}"
    user_data	     = "${file(var.user_data)}"
    key_name 	     = "${var.key_name}"
    tags {
        created_by = "${lookup(var.tags,"created_by")}"
        Name	     = "${var.instance_name}-${count.index}"
    }
}


/**
 * Outputs
 */

output "ec2_instance_id" {
  value = "${aws_instance.ec2_instance.id}"
}