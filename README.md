# AWS CSE IaC Full Deployment

Terraform project that deploys an intentionally insecure AWS sandbox environment (VPC, EC2, S3, RDS) for the [Cloud Security Engineering training](https://github.com/csdso-wavestone/aws-cse-guide). Trainees learn to identify vulnerabilities and remediate them via the AWS Console.

The EC2 instance runs the [picturegallery](https://github.com/csdso-wavestone/picturegallery) PHP app, backed by RDS MySQL, with S3 for static assets. A bootstrap script (`ec2-init.sh.tpl`) fully deploys the app at first boot.

## Files

- `versions.tf` — Terraform and provider versions (AWS, TLS).
- `variables.tf` — Input variables. Trainees only need to set their `trigram` and `db_password`.
- `locals.tf` — Naming conventions, tags, AMI lookup.
- `main.tf` — All AWS resources (VPC, subnets, security groups, EC2, S3 buckets, RDS).
- `ec2-init.sh.tpl` — EC2 bootstrap script run via `user_data` at first boot.
- `outputs.tf` — Deployment outputs (EC2 IP, RDS endpoint, S3 bucket names, SSH key).
- `terraform.tfvars.example` — Sample variable values to copy and edit.

## Usage

1. Copy the example vars and set your `trigram` and a strong `db_password`:
```bash
cp terraform.tfvars.example terraform.tfvars
```
2. Deploy:
```bash
terraform init
terraform plan
terraform apply
```

Deployment takes about 10 minutes (mostly RDS provisioning). The website is live when `terraform apply` finishes.

3. Retrieve outputs:
```bash
terraform output
terraform output -raw ec2_public_ip
terraform output -raw ec2_private_key_pem > cse-ec2-key.pem
chmod 400 cse-ec2-key.pem
```

## Author

Hani SAMI - hani.sami@wavestone.com (Do not hesitate to contact me if you have any questions !)
