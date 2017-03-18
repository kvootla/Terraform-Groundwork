variable "name" {}

variable "cidr" {}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

