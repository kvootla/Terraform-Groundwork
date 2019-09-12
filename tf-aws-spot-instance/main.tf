/**
* Inputs
*/

variable "count" {
  description = "Number of instances to launch"
  default     = 1
}

variable "ami_id" {
  description = "AMI to serve as base of server build"
}

variable "availability_zone" {
  description = "The AZ to start the instance in"
  default     = ""
}

variable "placement_group" {
  description = "The Placement Group to start the instance in"
  default     = ""
}

variable "tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host."
  default     = "default"
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = false
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  default     = false
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance"
  default     = ""
}

variable "instance_type" {
  default     = "t2.micro"
  description = "Instance type, see a list at: https://aws.amazon.com/ec2/instance-types/"
}

variable "key_name" {
  description = "The SSH key pair, key name"
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  default     = false
}

variable "security_groups" {
  description = "list of security group IDs"
  type        = "list"
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  default     = ""
}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  default     = false
}

variable "private_ip" {
  description = "Private IP address to associate with the instance in a VPC"
  default     = ""
}

variable "source_dest_check" {
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs."
  default     = true
}

variable "user_data" {
  description = "User data for the instances"
}

variable "iam_instance_profile" {
  description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
  default     = ""
}

variable "ipv6_address_count" {
  description = "A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet."
  default     = 0
}

variable "ipv6_addresses" {
  description = "Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface"
  default     = []
}

variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  default     = {}
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  default     = []
}

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  default     = []
}

variable "ephemeral_block_device" {
  description = "Customize Ephemeral (also known as Instance Store) volumes on the instance"
  default     = []
}

variable "network_interface" {
  description = "Customize network interfaces to be attached at instance boot time"
  default     = []
}

variable "spot_price" {
  type        = "string"
  description = "The maximum hourly price (bid) you are willing to pay for the instance, e.g. 0.10"
}

variable "wait_for_fulfillment" {
  description = "(Optional; Default: false) If set, Terraform will wait for the Spot Request to be fulfilled, and will throw an error if the timeout of 10m is reached."
  default     = false
}

variable "launch_group" {
  type        = "string"
  description = "Group name to assign the instances to so they can be started/stopped in unison, e.g. purple-plutonium"
  default     = ""
}

variable "instance_interruption_behaviour" {
  type        = "string"
  description = "Whether a Spot instance stops or terminates when it is interrupted, can be stop or terminate"
  default     = "terminate"
}

variable "block_duration_minutes" {
  type        = "string"
  description = "(Optional) The required duration for the Spot instances, in minutes. This value must be a multiple of 60 (60, 120, 180, 240, 300, or 360)."
  default     = "0"
}

variable "spot_type" {
  type        = "string"
  description = "(Optional; Default: 'persistent') If set to 'one-time', after the instance is terminated, the spot request will be closed. Also, Terraform can't manage one-time spot requests, just launch them."
  default     = "persistent"
}

variable "create_timeout" {
  description = "(Defaults to 10 mins) Used when requesting the spot instance (only valid if wait_for_fulfillment = true)"
  default     = "10m"
}

variable "delete_timeout" {
  description = "(Defaults to 10 mins) Used when terminating all instances launched via the given spot instance request"
  default     = "10m"
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
* Spot Instances
*/

resource "aws_spot_instance_request" "main" {
  ami                    = "${var.ami_id}"
  count                  = "${var.count}"
  instance_type          = "${var.instance_type}"
  user_data              = "${var.user_data}"
  subnet_id              = "${var.subnet_id}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_groups}"]
  iam_instance_profile   = "${var.iam_instance_profile}"
  monitoring             = true

  associate_public_ip_address = "${var.associate_public_ip_address}"
  private_ip                  = "${var.private_ip}"
  ipv6_address_count          = "${var.ipv6_address_count}"
  ipv6_addresses              = "${var.ipv6_addresses}"

  ebs_optimized          = "${var.ebs_optimized}"
  volume_tags            = "${var.volume_tags}"
  root_block_device      = "${var.root_block_device}"
  ebs_block_device       = "${var.ebs_block_device}"
  ephemeral_block_device = "${var.ephemeral_block_device}"

  source_dest_check                    = true
  disable_api_termination              = "${var.disable_api_termination}"
  instance_initiated_shutdown_behavior = "${var.instance_initiated_shutdown_behavior}"
  availability_zone                    = "${var.availability_zone}"
  placement_group                      = "${var.placement_group}"
  tenancy                              = "${var.tenancy}"

  spot_price                      = "${var.spot_price}"
  wait_for_fulfillment            = "${var.wait_for_fulfillment}"
  spot_type                       = "${var.spot_type}"
  instance_interruption_behaviour = "${var.instance_interruption_behaviour}"
  launch_group                    = "${var.launch_group}"
  block_duration_minutes          = "${var.block_duration_minutes}"

  timeouts {
    create = "${var.create_timeout}"
    delete = "${var.delete_timeout}"
  }

  # Note: network_interface can't be specified together with associate_public_ip_address
  # network_interface = "${var.network_interface}"

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

output "id" {
  description = "List of IDs of instances"
  value       = ["${aws_spot_instance_request.main.*.id}"]
}

#output "public_dns" {
#  description = "List of public DNS names assigned to the instances. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
#  value       = ["${aws_spot_instance_request.main.*.public_dns}"]
#}

#output "public_ip" {
#  description = "List of public IP addresses assigned to the instances, if applicable"
#  value       = ["${aws_spot_instance_request.main.*.public_ip}"]
#}

#output "private_dns" {
#  description = "List of private DNS names assigned to the instances. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
#  value       = ["${aws_spot_instance_request.main.*.private_dns}"]
#}

#output "private_ip" {
#  description = "List of private IP addresses assigned to the instances"
#  value       = ["${aws_spot_instance_request.main.*.private_ip}"]
#}

output "spot_bid_status" {
  description = "The current bid status of the Spot Instance Request."
  value       = ["${aws_spot_instance_request.main.*.spot_bid_status}"]
}

output "spot_request_state" {
  description = "The current request state of the Spot Instance Request."
  value       = ["${aws_spot_instance_request.main.*.spot_request_state}"]
}

#output "spot_instance_id" {
#  description = "The Instance ID (if any) that is currently fulfilling the Spot Instance request."
#  value       = ["${aws_spot_instance_request.main.*.spot_instance_id}"]
#}
