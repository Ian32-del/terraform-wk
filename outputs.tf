output "bucket_name" {
  description = "Name of the learning bucket"
  value       = aws_s3_bucket.learning.id
}

output "bucket_arn" {
  description = "ARN of the learning bucket"
  value       = aws_s3_bucket.learning.arn
}