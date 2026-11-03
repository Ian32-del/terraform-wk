variable "region" {
  type        = string
  description = "AWS region for all resources"
  default     = "eu-north-1"
}

variable "bucket_name" {
  type        = string
  description = "Globally unique S3 bucket name"
}

variable "environment" {
  type        = string
  description = "Environment label used in tags"
  default     = "learning"

  validation {
    condition     = contains(["learning", "dev", "prod"], var.environment)
    error_message = "Environment must be learning, dev or prod."
  }
}