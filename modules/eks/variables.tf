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

variable "aws_region" {
  description = "Región de AWS donde se desplegará el clúster"
  type        = string
}

variable "cliente_image" {
  description = "URL de la imagen Docker del cliente en Amazon ECR"
  type        = string
}

variable "servidor_image" {
  description = "URL de la imagen Docker del servidor en Amazon ECR"
  type        = string
}

variable "container_port" {
  description = "Puerto que expone el contenedor"
  type        = number
  default     = 50051
}

