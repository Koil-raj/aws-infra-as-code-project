provider "aws" {
  region = local.region
}

terraform {
  required_version = ">= 1.0"

  backend "s3" {
    bucket         = "eks-terraform-state-bucket-koil"
    key            = "backend-tf-folder/VPC.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    use_lockfile   = true
    dynamodb_table = "terraform-state-lock"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.53"
    }
  }
}

