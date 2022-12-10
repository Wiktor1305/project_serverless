output "bucket_arn" {
  value       = aws_s3_bucket.wiadro.*.arn
  description = "Bucket ARN"
}

output "bucket_domain_name" {
  value       = aws_s3_bucket.wiadro.*.bucket_domain_name
  description = "FQDN of bucket"
}

output "bucket_website_endpoint" {
  value       = aws_s3_bucket_website_configuration.wiadro.*.website_endpoint
  description = "The bucket website endpoint, if website is enabled"
}

