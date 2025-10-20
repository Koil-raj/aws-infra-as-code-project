######################
# EKS Add-ons
######################

resource "aws_eks_addon" "vpc_cni" {
  cluster_name                = aws_eks_cluster.ade-eks-cluster.name
  addon_name                  = "vpc-cni"
  addon_version               = "v1.20.2-eksbuild.1" # Optional, can be left out to get latest
  resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_addon" "coredns" {
  cluster_name                = aws_eks_cluster.ade-eks-cluster.name
  addon_name                  = "coredns"
  resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name                = aws_eks_cluster.ade-eks-cluster.name
  addon_name                  = "kube-proxy"
  resolve_conflicts_on_update = "PRESERVE"
}

resource "aws_eks_addon" "ebs_csi" {
  cluster_name                = aws_eks_cluster.ade-eks-cluster.name
  addon_name                  = "aws-ebs-csi-driver"
  resolve_conflicts_on_update = "PRESERVE"

  tags = {
    Name = "ebs-csi-addon"
  }

  depends_on = [
    aws_eks_node_group.eks-node,
    aws_iam_role_policy_attachment.eks-node-ebs-csi
  ]
}

resource "aws_eks_addon" "pod_identity" {
  cluster_name = aws_eks_cluster.ade-eks-cluster.name
  addon_name   = "eks-pod-identity-agent"
}

resource "aws_eks_addon" "external_dns" {
  cluster_name = aws_eks_cluster.ade-eks-cluster.name
  addon_name   = "external-dns"
}
