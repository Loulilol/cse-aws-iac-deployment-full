variable "aws_region" {
  description = "AWS region for deployment."
  type        = string
  default     = "eu-west-3"
}

variable "trigram" {
  description = "Short trainee identifier used in resource names to keep them unique per trainee."
  type        = string

  validation {
    condition     = can(regex("^[a-z]{2,4}$", var.trigram))
    error_message = "trigram must be 2 to 4 lowercase letters (e.g. jdo)."
  }
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

