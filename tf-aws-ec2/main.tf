/**
* Inputs
*/

variable "ami_id" {
  description = "AMI to serve as base of server build"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "Instance type, see a list at: https://aws.amazon.com/ec2/instance-types/"
}

variable "security_groups" {
  description = "list of security group IDs"
  type        = "list"
}

variable "key_name" {
  description = "The SSH key pair, key name"
}

variable "subnet_id" {
  description = "A external subnet id"
}

variable "private_ip" {
  description = "Private IP address"
  default     = ""
}

variable "public_ip" {
  description = "Public IP address"
  default     = "false"
}

variable "user_data" {
  description = "User data for the instances"
}

variable "root_block_volume_size" {
  description = "Root block volume size"
}

variable "root_block_volume_type" {
  description = "Root block volume type"
  default     = "gp2"
}

variable "root_block_delete_on_termination" {
  description = "Delete root block on instance termination"
  default     = "true"
}

variable "environment" {
  description = "Environment tag, e.g prod"
}

variable "organization" {
  description = "Organization tag e.g. dchbx"
}

variable "application" {
  description = "Application tag e.g. enroll"
}

/**
* Instances
*/

resource "aws_instance" "main" {
  ami                    = "${var.ami_id}"
  source_dest_check      = true
  instance_type          = "${var.instance_type}"
  subnet_id              = "${var.subnet_id}"
  private_ip             = "${var.private_ip}"
  public_ip              = "${var.public_ip}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_groups}"]
  monitoring             = true
  user_data              = "${var.user_data}"

  root_block_device = {
    volume_size           = "${var.root_block_volume_size}"
    delete_on_termination = "${var.root_block_delete_on_termination}"
    volume_type           = "${var.root_block_volume_type}"
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
