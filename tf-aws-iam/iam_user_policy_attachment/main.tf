/**
 * Inputs
 */

variable "user" {
  description = "Name of IAM user"
}

variable "policy_arn" {
  description = "The ARN of the policy to apply"
}

/**
* IAM User Policy Attachment
*/

resource "aws_iam_user_policy_attachment" "main" {
  user       = "${var.user}"
  policy_arn = "${var.policy_arn}"
}
