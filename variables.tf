variable "aws_region" {}

variable "vpc_cidr" {}

variable "vpc_name" {}

variable "availability_zones" {
  description = "A list of availability zones inside the VPC"
  default = []
}

variable "enable_dns_hostnames" {
  description = "True to use private DNS within the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "True to use private DNS within the VPC"
  default     = true
}

variable "map_public_ip_on_launch" {
  description = "True to auto-assign public IP on launch"
  default     = true
}

variable "public_propagating_vgws" {
  description = "A list of VGWs the public route table should propagate."
  default     = []
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  default = []
}

variable "aws_access_key" {}

variable "aws_secret_key" {}

