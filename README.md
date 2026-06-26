# CSE AWS Terraform Skeleton

This folder is the AWS Terraform skeleton aligned with the Azure full deployment IaC here: 
- [IaC_full_deployment-latest-vm-image-Azure/IaC_full_deployment-latest-vm-image/main.tf](https://github.com/csdso-wavestone/IaC_full_deployment/tree/latest-vm-image)

## Files
- `versions.tf`: Terraform + provider versions.
- `variables.tf`: input variables.
- `locals.tf`: naming, tags, data sources. (New addition in the AWS version !)
- `main.tf`: resource skeleton.
- `outputs.tf`: deployment outputs (useful for the training). (New addition in the AWS version !)
- `terraform.tfvars.example`: sample variable values.

## Naming and Tagging
- Required tag baseline: `Project=cse-aws`.
- Naming convention:
  - Base prefix: `cse-sbx-<trainee>-ew3` (TBC: fow now, by design, each trainee will receive a trainee ID associated with his sandbox/account)
  - S3 uniqueness is ensured by: `...-<accountid>`

## Usage
1. Copy example vars:
```bash
cp terraform.tfvars.example terraform.tfvars
```
2. Update values/variables in `terraform.tfvars` (Attention: `aws_profile = "cse"` is a profile that was used to create the training, delete it OR replace the profile with your own (associated with your AWS credentials) before deploying). `ec2_key_pair_name` can stay empty to auto-generate and create the key pair (unless you want to use your own ssh key).
3. Run:
```bash
terraform init
terraform plan
terraform apply
```

## Author
Hani SAMI - hani.sami@wavestone.com (Do not hesitate to contact me if you have any questions !)
