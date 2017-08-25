/**
 * Inputs
 */

variable "size" {
  description = "EBS volume size"
}

variable "type" {
  description = "EBS volume type"
}

variable "device_name" {
  description = "List of EBS device name"
}

variable "azs" {
  description = "A list of Availability zones in the region"
}

variable "ebs_encrypted" {
  description = "instance id to attach the ebs to particular instance"
}

variable "instance_id" {
  description = "Instance ID to serve as base of server build"
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

/**
 * Instance with EBS Volumes
 */

resource "aws_ebs_volume" "main" {
  type              = "${var.type}"
  size              = "${var.size}"
  encrypted         = "${var.ebs_encrypted}"
  availability_zone = "${var.azs}"

  tags {
    Name         = "${format("%s-%s-%s", var.organization, var.environment, var.application)}-i"
    Organization = "${var.organization}"
    Terraform    = "true"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "${var.device_name}"
  instance_id = "${var.instance_id}"
  volume_id   = "${aws_ebs_volume.main.id}"
}

/**
 * Outputs
 */

output "ebs_id" {
  value = "${aws_ebs_volume.main.id}"
}
