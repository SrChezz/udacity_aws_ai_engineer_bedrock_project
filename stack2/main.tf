provider "aws" {
  region = var.aws_region
}

module "bedrock_kb" {
  aws_region = var.aws_region
  source = "../modules/bedrock_kb" 

  knowledge_base_name        = "my-bedrock-kb"
  knowledge_base_description = "Knowledge base connected to Aurora Serverless database"

  aurora_arn        = var.aurora_arn 
  aurora_endpoint   = var.aurora_endpoint 
  aurora_db_name    = "myapp"
  aurora_table_name = "bedrock_integration.bedrock_kb"
  aurora_primary_key_field = "id"
  aurora_metadata_field    = "metadata"
  aurora_text_field        = "chunks"
  aurora_verctor_field     = "embedding"
  aurora_username          = "dbadmin"
  aurora_secret_arn        = var.aurora_secret_arn
  s3_bucket_arn            = var.s3_bucket_arn 
}