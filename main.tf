/**
 * Inputs
 */
  
variable "ami_id" {
  description = "AMI to serve as base of server build"
}

variable "instance_type" {
  description = "Instance type"
}
variable "instance_name" {
  description = "Used to populate the Name tag"
}

variable "number_of_instances" {
  description = "number of instances"
  default = 1
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}


variable "subnet_id" {
  description = "The VPC subnet the instance(s) will go in"
}

variable "vpc_id" {
  description = "VPC ID"
}

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

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "${var.aws_region}"
}

resource "aws_instance" "main" {
    ami		         = "${var.ami_id}"
    instance_type    = "${var.instance_type}"
    instance_name    = "${var.instance_name}"
    count	         = "${var.number_of_instances}"
    subnet_id	     = "${var.subnet_id}"
    vpc_id           = "${var.vpc_id}"
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
