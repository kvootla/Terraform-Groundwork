/**
 * Inputs
 */

variable "multi_az" {
  description = "Set to true on production"
  default     = false
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD)."
  default     = "gp2"
}

variable "allocated_storage" {
  description = "The allocated storage in GBs"
}

variable "storage_encrypted" {
  description = "Encrypted RDS storage"
  default     = true
}

variable "engine_type" {
  description = "Database engine type"
}

variable "engine_version" {
  description = "Database engine version, depends on engine type"
}

variable "instance_class" {
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

variable "publicly_accessible" {
  description = "Determines if database can be publicly available (NOT recommended)"
  default     = false
}

variable "subnet_ids" {
  description = "List of subnets DB should be available at. It might be one subnet."
  type        = "list"
}

variable "vpc_id" {
  description = "VPC to connect to, used for a security group"
  type        = "string"
}

variable "license_model" {
  description = "Typically included or BYOL"
  default     = "license-included"
}

variable "backup_retention_period" {
  description = "Backup retention period 1-35"
  default     = 35
}

variable "backup_window" {
  description = "Backup window in UTC"
  default     = "08:00-09:00"
}

variable "maintenance_window" {
  description = "Maintenance window in UTC w/ day of the week"
  default     = "sun:06:00-sun:07:00"
}

variable "security_groups" {
  description = "A list of security group IDs"
  type        = "list"
}

variable "environment" {
  description = "Environment tag, e.g prod"
}

variable "organization" {
  description = "Organization tag e.g. dchbx"
}

variable "database_type" {
  description = "Database type e.g. oracle"
}

/**
 * Relational Database Service
 */

resource "aws_db_instance" "main_rds_instance" {
  identifier        = "rds-${var.organization}-${var.environment}-${var.database_type}"
  allocated_storage = "${var.allocated_storage}"
  storage_type      = "${var.storage_type}"
  storage_encrypted = "${var.storage_encrypted}"
  engine            = "${var.engine_type}"
  engine_version    = "${var.engine_version}"
  license_model     = "${var.license_model}"
  instance_class    = "${var.instance_class}"

  name     = "${var.database_name}"
  username = "${var.database_user}"
  password = "${var.database_password}"
  port     = "${var.database_port}"

  publicly_accessible         = "${var.publicly_accessible}"
  allow_major_version_upgrade = "${var.allow_major_version_upgrade}"
  auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"
  backup_retention_period     = "${var.backup_retention_period}"
  backup_window               = "${var.backup_window}"
  maintenance_window          = "${var.maintenance_window}"

  multi_az               = "${var.multi_az}"
  db_subnet_group_name   = "${aws_db_subnet_group.main_db_subnet_group.name}"
  vpc_security_group_ids = ["${var.security_groups}"]
}

resource "aws_db_subnet_group" "main_db_subnet_group" {
  name       = "${var.organization}-${var.environment}"
  subnet_ids = ["${var.subnet_ids}"]
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
