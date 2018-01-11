/**
 * Inputs
 */
 
data "aws_caller_identity" "current" { }

variable "role_name" {
  description = "The name of the Role"
  default = "Delegate-Saml-Admin"
}
variable "role_policies" {
  description = "The policies attached to the role"
  default = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  type = "list"
}

variable "provider_name" {
  description = "The name of the provider."
  default = "default-saml-provider"
}
variable "provider_metadata_file" {
  description = "The path to of the metadatafile"
  default =""
}

/**
 * Saml
 */

resource "aws_iam_saml_provider" "saml" {
  name                   = "${var.provider_name}"
  saml_metadata_document = "${file(var.provider_metadata_file)}"
}

resource "aws_iam_role" "DelegateUser" {
    name = "${var.role_name}"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "${aws_iam_saml_provider.saml.id}"
      },
      "Action": "sts:AssumeRoleWithSAML",
      "Condition": {
        "StringEquals": {
          "SAML:aud": "https://signin.aws.amazon.com/saml"
        }
      }
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "DelegateUser_Attachment" {
    role = "${aws_iam_role.DelegateUser.name}"
    policy_arn = "${element(var.role_policies, count.index)}"
    count = "${length(var.role_policies)}"
}

/**
 * Outputs
 */

 output "role"{
  description = "ARN of the Role"
  value = "${aws_iam_role.DelegateUser.id}"
}
output "saml_provider"{
  description = "ARN of the SAML Provider"
  value = "${aws_iam_saml_provider.saml.id}"
}
