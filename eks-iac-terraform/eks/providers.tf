# Configure the AWS Provider

provider "aws" {
  region = var.region
}

# configuring required terraform version and backend bucket 

terraform {
  required_version = ">= 1.0"

  backend "s3" {
    bucket         = "eks-terraform-state-bucket-koil"
    key            = "backend-tf-folder/EKS.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    use_lockfile   = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.53"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.37.0"
    }
  }
}
