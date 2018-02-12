data "aws_caller_identity" "current" {}

variable "account_name" {
  description = "The name of the account."
  default     = "not_set"
}

variable "password_min_length" {
  description = "The minimal length of passwords."
  default     = 10
}

variable "password_reuse_prevention" {
  description = "Prevent reuse of the given amount of passwords."
  default     = 10
}

variable "password_hard_expiry" {
  description = "Requires administrative reset of the user after expiring."
  default     = false
}

variable "password_max_age" {
  description = "The maximum age before a password will expire."
  default     = 0
}

variable "trail_name" {
  description = "Name of the cloudtrail trail."
  default     = "Default"
}

variable "trail_bucketname" {
  description = "Name of the cloudtrail bucket. Will defaults to <account-id>-logs."
  default     = ""
}

variable "trail_bucketname_create" {
  description = "Defines if the bucket should be created."
  default     = 1
}
