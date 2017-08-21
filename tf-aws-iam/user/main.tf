/**
 * Inputs
 */

variable "name" {
  description = "Name of IAM user"
}

variable "path" {
  description = "Path in which to create the user"
  default     = "/"
}

variable "force_destroy" {
  description = "Force destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices"
  default     = false
}

/**
* IAM User
*/

resource "aws_iam_user" "main" {
  name          = "${var.name}"
  path          = "${var.path}"
  force_destroy = "${var.force_destroy}"
}

/**
 * Outputs Varibales
 */

output "arn" {
  value = "${aws_iam_user.main.arn}"
}

output "name" {
  value = "${aws_iam_user.main.name}"
}

output "unique_id" {
  value = "${aws_iam_user.main.unique_id}"
}
