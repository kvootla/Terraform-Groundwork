/**
 * Input Variables
 */

variable "instance_name" {
  description = "Used to populate the Name tag. This is done in main.tf"
}

variable "instance_type" {}

variable "subnet_id" {
  description = "The VPC subnet the instance(s) will go in"
}

variable "key_name" {}

variable "ami_id" {
  description = "The AMI to use"
}

variable "number_of_instances" {
  description = "number of instances to make"
  default = 1
}

variable "user_data" {
   description = "The path to a file with user_data for the instances"
}

variable "tags" {
  default = {
    created_by = "terraform"
 }
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}


variable "security_group_id" {
  description = "The name for the security group"
}

variable "vpc_id" {
  description = "The VPC ID"
  }

/**
 * EC2 Instance
 */

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "${var.aws_region}"
}

resource "aws_instance" "ec2_instance" {
    ami 			       = "${var.ami_id}"
    count 			     = "${var.number_of_instances}"
    subnet_id 		   = "${var.subnet_id}"
    instance_type    = "${var.instance_type}"
    user_data 		   = "${file(var.user_data)}"
    key_name 		     = "${var.key_name}"
    security_group_id   = "${var.security_group_id}"  
    vpc_id              = "${var.vpc_id}"

    tags {
        created_by = "${lookup(var.tags,"created_by")}"
        // Takes the instance_name input variable and adds
        //  the count.index to the name., e.g.
        //  "example-host-web-1"
        Name = "${var.instance_name}-${count.index}"
    }
}



/**
 * Outputs Varibales
 */

output "ec2_instance_id" {
  value = "${aws_instance.ec2_instance.id}"
}
