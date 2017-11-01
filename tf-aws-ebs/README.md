Module: AWS/EBS Volume
======================

A Terraform module for creating EBS Volume.

Module Input Variables
----------------------
- `volume_id` - The volume ID (e.g. vol-59fcb34e).
- `availability_zone` - The AZ where the EBS volume exists.
- `encrypted` - Whether the disk is encrypted.
- `iops` - The amount of IOPS for the disk.
- `size` - The size of the drive in GiBs.
- `snapshot_id` - The snapshot_id the EBS volume is based off.
- `volume_type` - The type of EBS volume.
- `kms_key_id` - The ARN for the KMS encryption key.
- `tags` - A mapping of tags for the resource.

Usage
-----

```hcl
module "ebs" {
  source = "github.com/kvootla/Terraform-Groundwork//tf-aws-ebs"

  type        = "${var.type}"
  size        = "${var.size}"
  device_name = "${var.device_name}"
  azs         = "${var.azs}"
  instance_id   = "${var.instance_id}"
  ebs_encrypted = "true"

  environment  = "prod"
  organization = "mhc"
  application  = "enroll"
}
```

Outputs
=======

- `id` - The volume ID (e.g. vol-59fcb34e)
