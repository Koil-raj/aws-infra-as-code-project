
################################
# Cluster admin role creation 
################################

resource "aws_iam_role" "eks" {
  name = "${local.cluster_name}-Cluser-Role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "eks.amazonaws.com"
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-master-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks.name

}

resource "aws_iam_role_policy_attachment" "eks-master-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks.name

}


################################
# Cluster creation module 
################################

resource "aws_eks_cluster" "eks-cluster" {
  name                      = local.cluster_name
  version                   = var.eks_version
  role_arn                  = aws_iam_role.eks.arn
  enabled_cluster_log_types = var.cluster-logging-types

  vpc_config {
    subnet_ids              = [data.aws_subnet.subnet_public_1.id, data.aws_subnet.subnet_private_2.id]
    endpoint_private_access = "true"
    endpoint_public_access  = "true"
  }

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }


  depends_on = [
    aws_iam_role_policy_attachment.eks-master-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-master-AmazonEKSServicePolicy,
  ]
  tags = {
    stage = "${var.stage}"
  }
}

resource "aws_eks_access_entry" "admin_access" {
  cluster_name  = local.cluster_name
  principal_arn = var.aws_auth_role_arn
  type          = "STANDARD"

  #depends on eks cluster creation
  depends_on = [aws_eks_cluster.eks-cluster]
}

resource "aws_eks_access_policy_association" "admin_access_association" {
  cluster_name  = aws_eks_access_entry.admin_access.cluster_name
  principal_arn = aws_eks_access_entry.admin_access.principal_arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_access_policy_association" "admin_policy_extra" {
  cluster_name  = aws_eks_access_entry.admin_access.cluster_name
  principal_arn = aws_eks_access_entry.admin_access.principal_arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"

  access_scope {
    type = "cluster"
  }
}

