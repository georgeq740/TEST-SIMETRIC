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

# Deployment del servidor
resource "kubernetes_deployment" "servidor" {
depends_on = [module.eks]
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
          image = "585768158376.dkr.ecr.us-east-1.amazonaws.com/servidor:latest" 

          port {
            container_port = 50051
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
depends_on = [module.eks]
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
          image = "585768158376.dkr.ecr.us-east-1.amazonaws.com/cliente:latest"

          port {
            container_port = 50051
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
