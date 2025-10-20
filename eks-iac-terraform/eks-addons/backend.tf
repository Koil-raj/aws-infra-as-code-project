terraform {
  backend "s3" {
    bucket         = "eks-terraform-state-bucket-koil"
    key            = "backend-tf-folder/HELM.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    use_lockfile   = true
  }
}

# configuring required terraform version  

terraform {
  required_version = ">= 1.0"

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





