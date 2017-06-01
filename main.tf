/**
 * Inputs
 */

variable "rds_instance_identifier" {
  description = "Custom name of the instance"
}

variable "rds_is_multi_az" {
  description = "Set to true on production"
  default     = false
}

variable "rds_storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD)."
  default     = "standard"
}

variable "rds_allocated_storage" {
  description = "The allocated storage in GBs"
}

variable "rds_engine_type" {
  description = "Database engine type"
}

variable "rds_engine_version" {
  description = "Database engine version, depends on engine type"
}

variable "rds_instance_class" {
  description = "Class of RDS instance"
}

variable "auto_minor_version_upgrade" {
  description = "Allow automated minor version upgrade"
  default     = true
}

variable "allow_major_version_upgrade" {
  description = "Allow major version upgrade"
  default     = false
}

variable "database_name" {
  description = "The name of the database to create"
}

variable "database_user" {}
variable "database_password" {}
variable "database_port" {}

variable "db_parameter_group" {
  description = "Parameter group, depends on DB engine used"
}

variable "publicly_accessible" {
  description = "Determines if database can be publicly available (NOT recommended)"
  default     = false
}

variable "subnet_group_name" {
  description = "A group name for the subnet"
}

variable "subnet_id" {
  description = "List of subnets DB should be available at. It might be one subnet."
  type        = "list"
}

variable "private_cidr" {
  description = "VPC private addressing, used for a security group"
  type        = "string"
}

variable "rds_vpc_id" {
  description = "VPC to connect to, used for a security group"
  type        = "string"
}

variable "security_groups" {
  description = "a comma separated lists of security group IDs"
}

variable "environment" {
  description = "Environment tag, e.g prod"
}

variable "organization" {
  description = "Organization tag e.g. dchbx"
}

variable "application" {
  description = "Application tag e.g. enroll"
}

/**
 * Relational Database Service
 */

resource "aws_db_instance" "main_rds_instance" {
  identifier        = "${var.rds_instance_identifier}"
  allocated_storage = "${var.rds_allocated_storage}"
  storage_type      = "${var.rds_storage_type}"
  engine_type       = "${var.rds_engine_type}"
  engine_version    = "${var.rds_engine_version}"
  instance_class    = "${var.rds_instance_class}"
  
  name              = "${var.database_name}"
  username          = "${var.database_user}"
  password          = "${var.database_password}"
  port              = "${var.database_port}"
  
  parameter_group_name        = "${aws_db_parameter_group.main_rds_instance.id}"
  publicly_accessible         = "${var.publicly_accessible}"  
  allow_major_version_upgrade = "${var.allow_major_version_upgrade}"
  auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"

  multi_az               = "${var.rds_is_multi_az}"
  db_subnet_group_name   = "${aws_db_subnet_group.main_db_subnet_group.name}"
  db_subnet_id           = ["${var.subnet_id}"]   
  vpc_security_group_ids = ["${split(",",var.security_groups)}"]

  tags {
    Name         = "${format("%s-%s-%s", var.organization, var.environment, var.application)}-i"
    Organization = "${var.organization}"
    Terraform    = "true"
   }
  }

resource "aws_db_parameter_group" "main_rds_instance" {
  name   = "${var.rds_instance_identifier}-${replace(var.db_parameter_group, ".", "")}-custom-params"
  family = "${var.db_parameter_group}"
}

resource "aws_db_subnet_group" "main_db_subnet_group" {
  name        = "${var.rds_instance_identifier}-subnetgrp"
  description = "RDS subnet group"
  subnet_ids  = ["${var.subnet_id}"]
}

/**
 * Outputs
 */

output "rds_instance_id" {
  value = "${aws_db_instance.main_rds_instance.id}"
}

output "rds_instance_address" {
  value = "${aws_db_instance.main_rds_instance.address}"
}

output "rds_instance_endpoint" {
  value = "${aws_db_instance.main_rds_instance.endpoint}"
}

