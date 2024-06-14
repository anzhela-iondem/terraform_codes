output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  value = var.eks_cluster_name
}



# output "cluster_certificate_authority_data" {
#   description = "The EKS cluster certificate authority data."
#   value       = module.eks.cluster_certificate_authority_data
# }
