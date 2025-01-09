output "eks_cluster_name" {
  description = "Nombre del clúster de EKS"
  value       = aws_eks_cluster.eks_cluster.name
}

output "eks_cluster_endpoint" {
  description = "Endpoint del clúster de EKS"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_certificate" {
  description = "Certificado CA del clúster de EKS"
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "alb_controller" {
  value = helm_release.alb_controller
}
