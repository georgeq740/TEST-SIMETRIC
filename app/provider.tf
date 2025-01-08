terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.16.1"
    }
  }
}
provider "aws" {
  region = module.config.region

  default_tags {
    tags = {
      Environment = terraform.workspace
      Owner       = var.owner
      CostCenter  = var.cost_center
      Name        = var.name
    }
  }
}


provider "kubernetes" {
  host                   = module.eks.eks_cluster_endpoint
  token                  = data.aws_eks_cluster_auth.eks_auth.token
  cluster_ca_certificate = base64decode(module.eks.eks_cluster_certificate)
}

data "aws_eks_cluster_auth" "eks_auth" {
  name = module.eks.eks_cluster_name
}

resource "kubernetes_deployment" "servidor" {
  metadata {
    name      = "servidor"
    namespace = "default"
  }

  spec {
    replicas = 1
    selector {
      match_labels = { app = "servidor" }
    }

    template {
      metadata {
        labels = { app = "servidor" }
      }

      spec {
        container {
          name  = "servidor"
          image = var.servidor_image  # Aquí se utiliza la variable para la imagen

          port {
            container_port = 50051  # Ajusta según el puerto que exponga tu servidor
          }

          resources {
            requests = { memory = "128Mi", cpu = "250m" }
            limits   = { memory = "256Mi", cpu = "500m" }
          }
        }
      }
    }
  }
}

# Deployment del cliente
resource "kubernetes_deployment" "cliente" {
  metadata {
    name      = "cliente"
    namespace = "default"
  }

  spec {
    replicas = 1
    selector {
      match_labels = { app = "cliente" }
    }

    template {
      metadata {
        labels = { app = "cliente" }
      }

      spec {
        container {
          name  = "cliente"
          image = var.cliente_image  # Aquí se utiliza la variable para la imagen

          env {
            name  = "GRPC_SERVER"
            value = "servidor-service.default.svc.cluster.local:50051"
          }

          port {
            container_port = 50051  # Ajusta si el cliente usa otro puerto
          }

          resources {
            requests = { memory = "128Mi", cpu = "250m" }
            limits   = { memory = "256Mi", cpu = "500m" }
          }
        }
      }
    }
  }
}

# Servicio del servidor
resource "kubernetes_service" "servidor_service" {
  metadata {
    name      = "servidor-service"
    namespace = "default"
  }

  spec {
    selector = { app = "servidor" }

    port {
      port        = 50051
      target_port = 50051
    }

    type = "ClusterIP"
  }
}
