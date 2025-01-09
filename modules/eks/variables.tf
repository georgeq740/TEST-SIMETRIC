variable "cluster_name" {
  description = "Nombre del clúster de EKS"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "public_subnet_ids" {
  description = "Lista de IDs de subnets públicas"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Lista de IDs de subnets privadas"
  type        = list(string)
}

variable "region" {
  description = "Región de AWS donde se desplegará el clúster"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}