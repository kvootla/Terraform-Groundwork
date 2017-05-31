/**
 * Inputs
 */

variable "rds_instance_identifier" {
  description = "Custom name of the instance"
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

variable "cidrs" {
  type        = "map"
  description = "A map with key being the availability zone and value the CIDR range."
}

variable "security_groups" {
  description = "a comma separated lists of security group IDs"
}

variable "subnet_id" {
  description = "A external subnet id"
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
  allow_major_version_upgrade = "${var.allow_major_version_upgrade}"
  auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"

  vpc_security_group_ids = ["${split(",",var.security_groups)}"]
  db_subnet_group_name   =  "${var.subnet_group_name}"
  db_subnet_id           = "${var.subnet_id}"   
  cidr_block             = "${var.cidrs[element(keys(var.cidrs), count.index)]}"

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
