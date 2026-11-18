output "bucket_name" {
  value = module.learning_bucket.bucket_id
}

output "bucket_arn" {
  value = module.learning_bucket.bucket_arn
}

output "instance_id" {
  value = aws_instance.learning.id
}