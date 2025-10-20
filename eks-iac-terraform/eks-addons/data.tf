# Here the data will wait till the eks cluster is up and pull data of the module/eks/output.tf file with value of "name"

# data is pulled from eks cluster state file
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket         = "eks-terraform-state-bucket-koil"
    key            = "backend-tf-folder/EKS.tfstate"
    region         = "eu-central-1"
  }
}

data "aws_eks_cluster" "eks-cluster" {
  name       = data.terraform_remote_state.eks.outputs.name # this is the output from eks module with the cluster name 
}

data "aws_eks_cluster_auth" "eks-cluster" {
  name       = data.terraform_remote_state.eks.outputs.name
}

#Terraform queries aws and fetch below details.

provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.eks-cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks-cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks-cluster.token
  }
}


# Configure the AWS Provider

provider "aws" {
  region = var.region
}


# pulling VPC details  
data "aws_vpc" "landing_zone_vpc" {
  tags = {
    Name = var.cluster_name
  }
}

