variable "aws_region" {
  description = "AWS region for deployment."
  type        = string
  default     = "eu-west-3"
}

variable "aws_profile" {
  description = "AWS CLI profile name used by Terraform provider."
  type        = string
  default     = "cse"
}

variable "region_short" {
  description = "Short region token used in resource naming."
  type        = string
  default     = "ew3"
}

variable "trainee_code" {
  description = "Short trainee identifier used in names (example: t01)."
  type        = string
  default     = "t01"

  validation {
    condition     = can(regex("^t[0-9]{2}$", var.trainee_code))
    error_message = "trainee_code must match ^t[0-9]{2}$ (example: t01)."
  }
}

variable "project_tag" {
  description = "Mandatory project tag value used by cleanup policy."
  type        = string
  default     = "cse-aws"

  validation {
    condition     = var.project_tag == lower(var.project_tag)
    error_message = "project_tag must be lowercase to match cleanup selector conventions."
  }
}

variable "environment" {
  description = "Environment tag value."
  type        = string
  default     = "sandbox"
}

variable "common_tags" {
  description = "Optional additional tags merged with baseline tags."
  type        = map(string)
  default     = {}
}

variable "vpc_cidr" {
  description = "VPC CIDR."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_az1" {
  description = "Public subnet CIDR (AZ1)."
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr_az2" {
  description = "Public subnet CIDR (AZ2)."
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone_az1" {
  description = "Availability Zone for public subnet 1."
  type        = string
  default     = "eu-west-3a"
}

variable "availability_zone_az2" {
  description = "Availability Zone for public subnet 2."
  type        = string
  default     = "eu-west-3b"
}

variable "ec2_instance_type" {
  description = "EC2 instance type for vulnerable app VM."
  type        = string
  default     = "t3.micro"
}

variable "ec2_key_pair_name" {
  description = "Optional EC2 key pair name override. Leave empty to auto-generate and create one during apply."
  type        = string
  default     = ""
}

variable "ec2_ami_id" {
  description = "Optional custom AMI ID. Leave empty to use latest Amazon Linux 2023."
  type        = string
  default     = ""
}

variable "db_name" {
  description = "Initial database name."
  type        = string
  default     = "picturegallery"
}

variable "db_username" {
  description = "Database admin username."
  type        = string
  default     = "adminformation"
}

variable "db_password" {
  description = "Database admin password."
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Allocated storage in GiB for RDS."
  type        = number
  default     = 20
}

variable "logo_bucket_purpose" {
  description = "Purpose token for public logo bucket name."
  type        = string
  default     = "logo"
}

variable "logs_bucket_purpose" {
  description = "Purpose token for logs bucket name."
  type        = string
  default     = "logs"
}
