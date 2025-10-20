#outputs for the helm releases 

output "metrics_server_version" {
  value = helm_release.metrics_server.version
}

output "cluster_autoscaler_version" {
  value = helm_release.cluster_autoscaler.version
}

output "aws_lbc_version" {
  value = helm_release.aws_lbc.version
}