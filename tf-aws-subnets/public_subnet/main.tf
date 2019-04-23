/**
 * Inputs
 */

variable "cidrs" {
  type        = "map"
  description = "A map with key being the availability zone and value the CIDR range."
}

variable "vpc_id" {
  description = "The VPC ID."
}

variable "igw_id" {
  description = "The Internet Gateway ID."
}

variable "map_public_ip_on_launch" {
  default = false
}

variable "subnet_type" {
  description = "An additional identifier in the subnet name and route table name (optional field)."
  default     = ""
}

variable "organization" {}
variable "environment" {}

/**
* Templates for tags
*/

data "template_file" "subnet_tag" {
  template = "$${organization}-$${environment}-pub$${separator}$${subnet_type}"

  vars {
    organization = "${var.organization}"
    environment  = "${var.environment}"
    separator    = "${var.subnet_type == "" ? "" : "-"}"
    subnet_type  = "${var.subnet_type}"
  }
}

/**
 * Subnets
 */

resource "aws_subnet" "main" {
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${var.cidrs[element(keys(var.cidrs), count.index)]}"
  availability_zone       = "${element(keys(var.cidrs), count.index)}"
  count                   = "${length(keys(var.cidrs))}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name         = "${format("%s-%s", data.template_file.subnet_tag.rendered, substr(element(keys(var.cidrs), count.index), -2, -1))}-subnet"
    Organization = "${var.organization}"
    Terraform    = "true"
  }
}

/**
 * Routes
 */

resource "aws_route_table" "main" {
  vpc_id = "${var.vpc_id}"
  count  = 1

  tags {
    Name         = "${format("%s", data.template_file.subnet_tag.rendered)}-rtb"
    Organization = "${var.organization}"
    Terraform    = "true"
  }
}

resource "aws_route_table_association" "main" {
  subnet_id      = "${element(aws_subnet.main.*.id, count.index)}"
  route_table_id = "${aws_route_table.main.id}"
  count          = "${length(keys(var.cidrs))}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route" "igw" {
  route_table_id         = "${aws_route_table.main.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${var.igw_id}"
  count                  = 1

  depends_on = [
    "aws_route_table.main",
  ]

  lifecycle {
    create_before_destroy = true
  }
}

/**
 * Outputs
 */

output "subnet_ids" {
  value = ["${aws_subnet.main.*.id}"]
}

output "subnet_id_map" {
  value = "${zipmap(aws_subnet.main.*.cidr_block, aws_subnet.main.*.id)}"
}

output "subnet_az_map" {
  value = "${zipmap(aws_subnet.main.*.availability_zone, aws_subnet.main.*.id)}"
}

output "route_table_id" {
  value = "${aws_route_table.main.id}"
}
