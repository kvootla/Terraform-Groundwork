/**
* Inputs
*/

variable "instance_type" {
  default     = "t2.micro"
  description = "Instance type, see a list at: https://aws.amazon.com/ec2/instance-types/"
}

variable "ami_id" {
  description = "AMI to serve as base of server build"
}

variable "security_groups" {
  description = "list of security group IDs"
  type        = "list"
}

variable "subnet_id" {
  description = "A external subnet id"
}

variable "private_ip" {
  description = "Private IP address"
  default     = ""
}

variable "key_name" {
  description = "The SSH key pair, key name"
}

variable "root_block_volume_size" {
  description = "Root block volume size"
}

variable "root_block_volume_type" {
  description = "Root block volume type"
  default     = "gp2"
}

variable "user_data" {
  description = "User data for the instances"
}

variable "root_block_delete_on_termination" {
  description = "Delete root block on instance termination"
  default     = "true"
}

variable "disable_api_termination" {
  description = "enables EC2 Instance Termination Protection"
  default     = "true"
}

variable "environment" {
  description = "Environment tag for the instance, e.g prod"
}

variable "organization" {
  description = "Organization tag for the instance, e.g. dchbx"
}

variable "application" {
  description = "Application tag for the instance, e.g. enroll"
}

/**
* EC2 Instances
*/

resource "aws_instance" "main" {
  ami                     = "${var.ami_id}"
  key_name                = "${var.key_name}"
  user_data               = "${var.user_data}"
  subnet_id               = "${var.subnet_id}"
  private_ip              = "${var.private_ip}"
  instance_type           = "${var.instance_type}"
  vpc_security_group_ids  = ["${var.security_groups}"]
  disable_api_termination = "${var.disable_api_termination}"

  monitoring        = true
  source_dest_check = true

  root_block_device = {
    volume_type           = "${var.root_block_volume_type}"
    volume_size           = "${var.root_block_volume_size}"
    delete_on_termination = "${var.root_block_delete_on_termination}"
  }

  tags {
    Name         = "${format("%s-%s-%s", var.organization, var.environment, var.application)}-i"
    Organization = "${var.organization}"
    Environment  = "${var.environment}"
    Terraform    = "true"
  }
}

/**
* Outputs
*/

output "instance_id" {
  value = "${aws_instance.main.id}"
}
