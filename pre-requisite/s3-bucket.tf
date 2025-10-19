provider "aws" {
  region = "eu-central-1"  # Change as needed
}

#creates S3 bucket
resource "aws_s3_bucket" "tf_state" {
  bucket = "eks-terraform-state-bucket-koil"  

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "Dev"
  }
}

#enable versioning for S3 to avoid issues with state file deletion
resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

#creates dynamobd to lock state file while running terraform apply
resource "aws_dynamodb_table" "tf_locks" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Locks Table"
    Environment = "Dev"
  }
}
