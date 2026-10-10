# AWS region where all resources will be deployed
variable "aws_region" {
  type    = string
  default = "eu-west-3"
}

# Short trainee identifier used in resource names to keep them unique per trainee
variable "nickname" {
  type    = string
  default = "trigram" # Replace this by your trigram, e.g., jdo for "John Doe" in lower case
}

# Short region token used in resource naming
variable "region_short" {
  type    = string
  default = "ew3"
}

# Mandatory project tag used by cleanup policy
variable "project_tag" {
  type    = string
  default = "cse-aws"
}

# Environment tag value
variable "environment" {
  type    = string
  default = "sandbox"
}

# VPC CIDR block
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

# Public subnet CIDRs — two subnets in different Availability Zones (required by RDS)
variable "public_subnet_cidr_az1" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public_subnet_cidr_az2" {
  type    = string
  default = "10.0.2.0/24"
}

variable "availability_zone_az1" {
  type    = string
  default = "eu-west-3a"
}

variable "availability_zone_az2" {
  type    = string
  default = "eu-west-3b"
}

# EC2 instance type for the app VM
variable "ec2_instance_type" {
  type    = string
  default = "t3.micro"
}

# Database configuration
variable "db_name" {
  type    = string
  default = "picturegallery"
}

variable "db_username" {
  type    = string
  default = "adminformation"
}

# Database admin password — you MUST set this. Choose a strong password and save it to your notepad.
variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_allocated_storage" {
  type    = number
  default = 20
}