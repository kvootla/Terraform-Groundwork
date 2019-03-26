/**
 * Inputs
 */

variable "name" {
  description = "Name of IAM user"
}

variable "assume_role_policy" {
  description = "Assume Role Policy."
  default     = ""
}

variable "force_detach_policies" {
  description = "Forcibly detach the policy of the role."
  default     = false
}

variable "path" {
  description = "Path in which to create the user"
  default     = "/"
}

variable "description" {
  description = "The description of the IAM Role."
  default     = "IAM Role generated by Terraform"
}

variable "policy_arn" {
  description = "Attache the policies to the IAM Role."
  type        = "list"
}

/**
 * IAM Role, IAM Instance Profile, IAM Role Policy Attachment
 */

data "aws_iam_policy_document" "main" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "main" {
  name                  = "${var.name}"
  assume_role_policy    = "${var.assume_role_policy == "" ? data.aws_iam_policy_document.this.json : var.assume_role_policy}"
  force_detach_policies = "${var.force_detach_policies}"
  path                  = "${var.path}"
  description           = "${var.description}"
}

resource "aws_iam_instance_profile" "main" {
  name       = "${format("%s-%s", var.name, "instance-profile")}"
  path       = "${var.path}"
  role       = "${aws_iam_role.main.name}"
  depends_on = ["aws_iam_role.main"]
}

resource "aws_iam_role_policy_attachment" "main" {
  count      = "${length(var.policy_arn)}"
  role       = "${aws_iam_role.main.name}"
  policy_arn = "${var.policy_arn[count.index]}"
}

/**
 * Outputs
 */

output "arn" {
  value = "${aws_iam_role.main.arn}"
}

output "unique_id" {
  value = "${aws_iam_role.main.unique_id}"
}

output "name" {
  value = "${aws_iam_instance_profile.main.name}"
}
