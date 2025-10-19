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


