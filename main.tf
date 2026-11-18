terraform {

  backend "s3" {
    bucket       = "chris-tfstate-48213"
    key          = "week1/terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }


}

provider "aws" {
  region = var.region
}

locals {
  common_tags = {
    Project     = "devops-learning"
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_s3_bucket" "learning" {
  bucket = var.bucket_name
  tags   = local.common_tags
}