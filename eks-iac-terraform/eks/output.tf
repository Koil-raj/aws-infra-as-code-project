#
# Outputs
#

###

output "endpoint" {
  value = aws_eks_cluster.eks-cluster.endpoint
}

output "certificate" {
  value = aws_eks_cluster.eks-cluster.certificate_authority[0].data
}

output "name" {
  value = aws_eks_cluster.eks-cluster.id
}

output "arn" {
  value = aws_eks_cluster.eks-cluster.arn
}

output "platform-version" {
  value = aws_eks_cluster.eks-cluster.platform_version
}

output "version" {
  value = aws_eks_cluster.eks-cluster.version
}

output "cluster_sg_id" {
  value = aws_eks_cluster.eks-cluster.vpc_config.0.cluster_security_group_id
}
