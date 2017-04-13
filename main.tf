/**
 * Input Variables
 */

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}

variable "rds_instance_identifier" {
    description = "Custom name of the instance"
}

variable "rds_is_multi_az" {
    description = "Set to true on production"
    default = false
}

variable "rds_storage_type" {
    description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD)."
    default = "standard"
}

variable "rds_allocated_storage" {
    description = "The allocated storage in GBs"
    # You just give it the number, e.g. 10
}

variable "rds_engine_type" {
    description = "Database engine type"
    # Valid types are
    # - mysql
    # - postgres
    # - oracle-*
    # - sqlserver-*
}

variable "rds_engine_version" {
    description = "Database engine version, depends on engine type"
}

variable "rds_instance_class" {
    description = "Class of RDS instance"
}

variable "auto_minor_version_upgrade" {
    description = "Allow automated minor version upgrade"
    default = true
}

variable "allow_major_version_upgrade" {
    description = "Allow major version upgrade"
    default = false
}

variable "database_name" {
    description = "The name of the database to create"
}

variable "database_user" {}
variable "database_password" {}
variable "database_port" {}

variable "db_parameter_group" {
    description = "Parameter group, depends on DB engine used"
    # default = "mysql5.6"
    # default = "postgres9.5"
}

variable "publicly_accessible" {
    description = "Determines if database can be publicly available (NOT recommended)"
    default = false
}

variable "subnets" {
    description = "List of subnets DB should be available at. It might be one subnet."
    type = "list"
}

variable "private_cidr" {
    description = "VPC private addressing, used for a security group"
    type = "string"
}

variable "rds_vpc_id" {
    description = "VPC to connect to, used for a security group"
    type = "string"
}


/**
 * RDS
 */

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

resource "aws_db_instance" "main_rds_instance" {
    identifier = "${var.rds_instance_identifier}"
    allocated_storage = "${var.rds_allocated_storage}"
    engine = "${var.rds_engine_type}"
    engine_version = "${var.rds_engine_version}"
    instance_class = "${var.rds_instance_class}"
    name = "${var.database_name}"
    username = "${var.database_user}"
    password = "${var.database_password}"

    port = "${var.database_port}"
    # Because we're assuming a VPC, we use this option, but only one SG id
    vpc_security_group_ids = ["${aws_security_group.main_db_access.id}"]

    # We're creating a subnet group in the module and passing in the name
    db_subnet_group_name = "${aws_db_subnet_group.main_db_subnet_group.name}"
    parameter_group_name = "${aws_db_parameter_group.main_rds_instance.id}"

    # We want the multi-az setting to be toggleable, but off by default
    multi_az = "${var.rds_is_multi_az}"
    storage_type = "${var.rds_storage_type}"
    publicly_accessible = "${var.publicly_accessible}"

    # Upgrades
    allow_major_version_upgrade = "${var.allow_major_version_upgrade}"
    auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"
}

resource "aws_db_parameter_group" "main_rds_instance" {
    name = "${var.rds_instance_identifier}-${replace(var.db_parameter_group, ".", "")}-custom-params"
    family = "${var.db_parameter_group}"
}

resource "aws_db_subnet_group" "main_db_subnet_group" {
    name = "${var.rds_instance_identifier}-subnetgrp"
    description = "RDS subnet group"
    subnet_ids = ["${var.subnets}"]
}

# Security groups
resource "aws_security_group" "main_db_access" {
    name = "Database access"
    description = "Allow access to the database"
    vpc_id = "${var.rds_vpc_id}"
}

resource "aws_security_group_rule" "allow_db_access" {
    type = "ingress"

    from_port = "${var.database_port}"
    to_port = "${var.database_port}"
    protocol = "tcp"
    cidr_blocks = ["${var.private_cidr}"]

    security_group_id = "${aws_security_group.main_db_access.id}"
}

resource "aws_security_group_rule" "allow_all_outbound" {
    type = "egress"

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

    security_group_id = "${aws_security_group.main_db_access.id}"
}


/**
 * Outputs Varibales
 */

# Output the ID of the RDS instance
output "rds_instance_id" {
    value = "${aws_db_instance.main_rds_instance.id}"
}

# Output the address (aka hostname) of the RDS instance
output "rds_instance_address" {
    value = "${aws_db_instance.main_rds_instance.address}"
}

# Output endpoint (hostname:port) of the RDS instance
output "rds_instance_endpoint" {
    value = "${aws_db_instance.main_rds_instance.endpoint}"
}

# Output the ID of the Subnet Group
output "subnet_group_id" {
    value = "${aws_db_subnet_group.main_db_subnet_group.id}"
}

# Output DB security group ID
output "security_group_id" {
    value = "${aws_security_group.main_db_access.id}"
}
