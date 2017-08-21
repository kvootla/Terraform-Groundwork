Module: AWS/Elastic IP
======================

A Terraform module to allocate EIP and associate its with an EC2 instance.


Module Input Variables
----------------------

 - `vpc`          - vpc id
 - `instance_ids` - list of instance IDs

Usage
-----

```hcl
module "eip" {
  source       = "github.com/kvootla/Terraform-Groundwork//tf-aws-eip"

  vpc          = true
  instance_ids = "i-aabbccdd,i-aabbccee,i-aabbccff"
}
```

Outputs
=======

- `public_ip` - comma separated list of public IPs allocated
