output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "eks_cluster_name" {
  description = "Nombre del clúster de EKS"
  value       = module.eks.eks_cluster_name
}

output "eks_service_endpoint" {
  description = "Endpoint del clúster de EKS"
  value       = module.eks.eks_cluster_endpoint
}

output "eks_cluster_certificate" {
  description = "Certificado CA del clúster de EKS"
  value       = module.eks.eks_cluster_certificate
}
