######################
# EKS Add-ons
######################

resource "aws_eks_addon" "vpc_cni" {
  cluster_name                = aws_eks_cluster.eks-cluster.name
  addon_name                  = "vpc-cni"
  addon_version               = "v1.20.2-eksbuild.1" # Optional, can be left out to get latest
  resolve_conflicts_on_update = "PRESERVE"

  depends_on = [
    aws_eks_node_group.eks-node
  ]
}

resource "aws_eks_addon" "coredns" {
  cluster_name                = aws_eks_cluster.eks-cluster.name
  addon_name                  = "coredns"
  resolve_conflicts_on_update = "PRESERVE"

  depends_on = [
    aws_eks_node_group.eks-node
  ]

}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name                = aws_eks_cluster.eks-cluster.name
  addon_name                  = "kube-proxy"
  resolve_conflicts_on_update = "PRESERVE"

  depends_on = [
    aws_eks_node_group.eks-node
  ]
}

resource "aws_eks_addon" "pod_identity" {
  cluster_name = aws_eks_cluster.eks-cluster.name
  addon_name   = "eks-pod-identity-agent"

  depends_on = [
    aws_eks_node_group.eks-node
  ]
}

resource "aws_eks_addon" "ebs_csi" {
  cluster_name                = aws_eks_cluster.eks-cluster.name
  addon_name                  = "aws-ebs-csi-driver"
  resolve_conflicts_on_update = "PRESERVE"

  tags = {
    Name = "ebs-csi-addon"
  }

  depends_on = [
    aws_iam_role.ebs_csi_driver
  ]
}

# In new terraform version the ebs sci driver using pod identity association instead of taking permissions from node group IAM role
resource "aws_iam_role" "ebs_csi_driver" {
  name = "${local.cluster_name}-ebs-csi-driver"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ebs_csi_driver" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.ebs_csi_driver.name
}

resource "aws_eks_pod_identity_association" "ebs_csi_driver" {
  cluster_name    = local.cluster_name
  namespace       = "kube-system"
  service_account = "ebs-csi-controller-sa"
  role_arn        = aws_iam_role.ebs_csi_driver.arn
}
