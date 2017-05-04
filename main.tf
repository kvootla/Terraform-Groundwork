/**
 * Input Variables
 */

variable "ami_id" {
  description = "AMI to serve as base of server build"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "Instance type, see a list at: https://aws.amazon.com/ec2/instance-types/"
}

variable "security_groups" {
  type        = "list"
  description = "a comma separated lists of security group IDs"
  default     = []
}

variable "user_data" {
   description = "The path to a file with user_data for the instances"
}

variable "key_name" {
  description = "The SSH key pair, key name"
}

variable "subnet_id" {
  description = "A external subnet id"
}

variable "environment" {
  description = "Environment tag, e.g prod"
}

variable "organization" {
  description = "Organization tag e.g. dchbx"
}

variable "application" {
  description = "Application tag e.g. dchbx"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}


/**
 * EC2 Instance
 */

 provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "${var.aws_region}"
}

resource "aws_instance" "main" {
  ami                    = "${var.ami_id}"
  source_dest_check      = true
  instance_type          = "${var.instance_type}"
  subnet_id              = "${var.subnet_id}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = "${var.security_groups[count.index]}"
  monitoring             = true
  user_data              = "${file("filepath.sh")}"

  tags {
    Name         = "${format("%s-%s-%s", var.organization, var.environment, var.application)}-i"
    Organization = "${var.organization}"
    Terraform    = "true"
  }
}


/**
 * Outputs Variables
 */

output "main_id" {
  value = "${aws_instance.main.id}"
}
