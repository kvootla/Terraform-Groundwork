/*
 * Inputs
 */

variable "minimum_length" {
  description = "The minimum length of a password"
  default     = 9
}

variable "require_lowercase" {
  description = "Do we require lowercase characters in the password"
  default     = true
}

variable "require_uppercase" {
  description = "Do we require uppercase characters in the password"
  default     = true
}

variable "require_numbers" {
  description = "Do we require numbers in the password"
  default     = true
}

variable "require_symbols" {
  description = "Do we require symbols in the password"
  default     = true
}

variable "allow_user_change" {
  description = "Do we allow people to change their own password?"
  default     = true
}

variable "hard_expiry" {
  description = "Do we allow people to change passwords that have expired?"
  default     = false
}

variable "maximum_age" {
  description = "The maximum age of a password (in days)"
  default     = 30
}

variable "reuse_history" {
  description = "The number of previous passwords that users are prevented from reusing."
  default     = 24
}


/**
 * iam account password policy
 */

resource "aws_iam_account_password_policy" "main" {
  minimum_password_length        = "${var.minimum_length}"
  require_lowercase_characters   = "${var.require_lowercase}"
  require_uppercase_characters   = "${var.require_uppercase}"
  require_numbers                = "${var.require_numbers}"
  require_symbols                = "${var.require_symbols}"
  allow_users_to_change_password = "${var.allow_user_change}"
  hard_expiry                    = "${var.hard_expiry}"
  max_password_age               = "${var.maximum_age}"
  password_reuse_prevention      = "${var.reuse_history}"
}
