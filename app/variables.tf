variable "owner" {
  description = "El propietario del proyecto"
  type        = string
  default     = "Jorge Quitian"
}

variable "cost_center" {
  description = "Centro de costos asociado al proyecto"
  type        = string
  default     = "ABC123"
}

variable "name" {
  description = "Nombre base para los recursos"
  type        = string
  default     = "test-simetric"
}

variable "namespace" {
  description = "Namespace donde se desplegará la aplicación"
  type        = string
  default     = "default"
}

variable "replicas" {
  description = "Número de réplicas de la aplicación"
  type        = number
  default     = 2
}

variable "container_image" {
  description = "Imagen Docker para la aplicación"
  type        = string
  default     = "nginx:latest"
}

variable "memory_request" {
  description = "Memoria solicitada por el contenedor"
  type        = string
  default     = "128Mi"
}

variable "cpu_request" {
  description = "CPU solicitada por el contenedor"
  type        = string
  default     = "250m"
}

variable "memory_limit" {
  description = "Límite de memoria para el contenedor"
  type        = string
  default     = "256Mi"
}

variable "cpu_limit" {
  description = "Límite de CPU para el contenedor"
  type        = string
  default     = "500m"
}

variable "service_port" {
  description = "Puerto expuesto por el servicio"
  type        = number
  default     = 80
}

variable "ingress_path" {
  description = "Ruta para el Ingress"
  type        = string
  default     = "/"
}

variable "app_hostname" {
  description = "Hostname para el Ingress"
  type        = string
  default     = "app.example.com"
}

variable "ingress_annotations" {
  description = "Anotaciones para el Ingress"
  type        = map(string)
  default     = {
    "kubernetes.io/ingress.class" = "alb"
    "alb.ingress.kubernetes.io/scheme" = "internet-facing"
  }
}

variable "alb_scheme" {
  description = "Esquema del ALB (internet-facing o internal)"
  type        = string
  default     = "internet-facing"
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


