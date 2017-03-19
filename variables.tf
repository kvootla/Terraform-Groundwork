variable "name" {}

variable "cidr" {}

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {}

variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = false
}

variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = false
}
