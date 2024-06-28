output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  value = var.eks_cluster_name
}
