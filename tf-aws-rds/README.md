Module: AWS_RDS
===============

A Terraform Template for RDS.


Module Input Variables
----------------------

- `rds_instance_identifier`     - Custom name of the DB instance (NOT a database name)
- `rds_is_multi_az`             - Defaults to false. Set to true for a multi-az  instance.
- `rds_storage_type`            - Defaults to standard (magnetic)
- `rds_allocated_storage`       - The number of GBs to allocate. Input must be an integer, e.g. `10`
- `rds_engine_type`             - Engine type, such as `mysql` or `postgres`
- `rds_engine_version`          - eg. `9.5.4` in case of postgres
- `rds_instance_class`          - instance size, eg. `db.t2.micro`
- `database_name`               - name of the dabatase
- `database_user`               - user name (admin user)
- `database_password`           - password - must be longer than 8 characters
- `db_parameter_group`          - Defaults to `mysql5.6`, for postgres `postgres9.5`
- `subnets`                     - List of subnets IDs in a list form, eg. `["sb-1234567890", "sb-0987654321"]`
- `database_port`               - Database port (needed for a security group)
- `publicly_accessible`         - Defaults to `false`
- `private_cidr`                - CIDR for database security group, eg 10.0.0.0/16
- `rds_vpc_id`                  - VPC ID DB will be connected to
- `allow_major_version_upgrade` - Allow upgrading of major version of database (eg. from Postgres 9.5.x to Postgres 9.6.x), default: false
- `auto_minor_version_upgrade`  - Automatically upgrade minor version of the DB (eg. from Postgres 9.5.3 to Postgres 9.5.4), default: true

Usage
-----

```hcl
module "my_rds_instance" {
  source               = "github.com/kvootla/Terraform-Groundwork//tf-aws-rds"

    # RDS Instance Inputs
    rds_instance_identifier = "${var.rds_instance_identifier}"
    rds_allocated_storage   = "${var.rds_allocated_storage}"
    rds_engine_type         = "${var.rds_engine_type}"
    rds_instance_class      = "${var.rds_instance_class}"
    rds_engine_version      = "${var.rds_engine_version}"
    db_parameter_group      = "${var.db_parameter_group}"

    database_name     = "${var.database_name}"
    database_user     = "${var.database_user}"
    database_password = "${var.database_password}"
    database_port     = "${var.database_port}"

    subnets      = ["${aws_subnet.*.id}"] #
    rds_vpc_id   = "${module.vpc}"
    private_cidr = "${var.private_cidr}"
}
```

Outputs
=======

- `rds_instance_id`      - The ID of the RDS instance
- `rds_instance_address` - The Address of the RDS instance
- `subnet_group_id`      - The ID of the Subnet Group
