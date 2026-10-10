output "ec2_public_ip" {
  description = "Application VM public IP."
  value       = aws_instance.app_vm.public_ip
}

output "application_url" {
  description = "Expected base URL for the gallery app."
  value       = "http://${aws_instance.app_vm.public_ip}/picturegallery"
}

output "logo_bucket_name" {
  description = "S3 bucket for public logo objects."
  value       = aws_s3_bucket.logo.bucket
}

output "logs_bucket_name" {
  description = "S3 bucket for training logs."
  value       = aws_s3_bucket.logs.bucket
}

output "rds_endpoint" {
  description = "RDS endpoint for application DB connectivity."
  value       = aws_db_instance.mysql.endpoint
}

output "ec2_key_pair_name" {
  description = "EC2 key pair name used by the app VM."
  value       = aws_key_pair.app_vm.key_name
}

output "ec2_private_key_pem" {
  description = "Generated private key for SSH access to app VM. Handle securely."
  value       = tls_private_key.ec2_ssh.private_key_pem
  sensitive   = true
}