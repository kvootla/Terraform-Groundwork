Module: AWS/VPC
===============

A Terraform module to provide a VPC in AWS.


Module Input Variables
----------------------

- `cidr` 		 - VPC cidr
- `enable_dns_hostnames` - should be true if you want to use private DNS within the VPC (optional - default: true)
- `enable_dns_support`   - should be true if you want to use private DNS within the VPC (optional - default: true)
- `organization` 	 - organization for whom the VPC will be used (lowercase abbreviations)
- `environment` 	 - environment, e.g. prod, preprod, etc. (optional - default: true)

Usage
-----

```hcl
module "vpc" {
  source       = "github.com/dchbx/infrastructure_modules//aws/vpc"
  cidr         = "10.0.0.0/16"
  
  organization = "dchbx"
  environment  = "prod"
}
```

Outputs
=======

 - `vpc_id` - VPC ID