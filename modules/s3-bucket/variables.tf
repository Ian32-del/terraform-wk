variable "bucket_name" {
  type        = string
  description = "Globally unique S3 bucket name"
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the bucket"
  default     = {}
}

variable "versioning" {
  type        = bool
  description = "Turn on object versioning"
  default     = false
}