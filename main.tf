/**
 * Input Variables
 */

variable "ebs_size" {
  description = "EBS volume size"
}

variable "ebs_type" {
  description = "EBS volume type"
  default     = "gp2"
}

variable "device_name" {
  description = "List of EBS device name"
}

variable "azs" {
  description = "A list of Availability zones in the region"
  default     = []
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

resource "aws_ebs_volume" "ebs" {
  volume_type       = "${var.ebs_type}"
  volume_size       = "${var.ebs_size}"
  encrypted         = "${var.ebs_encrypted}"
  availability_zone = "${element(var.azs, count.index)}"

  tags {
    Name         = "${format("%s-%s-%s", var.organization, var.environment, var.application)}-i"
    Organization = "${var.organization}"
    Terraform    = "true"
  }
}

resource "aws_volume_attachment" "ebs_attachment" {
  device_name = "${var.device_name}"
  volume_id   = "${aws_ebs_volume.ebs.*.id}"
  instance_id = "${var.instance_id}"
}

/**
 * Outputs Variables
 */

output "ebs_id" {
  value = "${aws_instance.main.id}"
}
