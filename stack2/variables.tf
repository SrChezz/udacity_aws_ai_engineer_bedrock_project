variable "aws_region" { 
    type        = string
    description = "AWS region for deployment"
    default     = "us-east-1" 
}

variable "aurora_arn" {}
variable "aurora_secret_arn" {}
variable "aurora_endpoint" {}
variable "s3_bucket_arn" {}
variable "s3_bucket_name" {}
variable "db_endpoint" {}
