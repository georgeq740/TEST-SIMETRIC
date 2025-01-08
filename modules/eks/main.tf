# Crear el clúster de EKS
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = concat(var.public_subnet_ids, var.private_subnet_ids)
  }
}

# Rol IAM para el clúster de EKS
resource "aws_iam_role" "eks_role" {
  name = "${var.cluster_name}-eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Adjuntar políticas al rol del clúster EKS
resource "aws_iam_role_policy_attachment" "eks_policy_attachment" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_vpc_cni_attachment" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

resource "aws_iam_role_policy_attachment" "eks_service_attachment" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

# Nodo de autenticación para Kubernetes
data "aws_eks_cluster_auth" "eks_auth" {
  name = aws_eks_cluster.eks_cluster.name
}


# Deployment del servidor
resource "kubernetes_deployment" "servidor" {
  metadata {
    name      = "servidor"
    namespace = "default"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "servidor"
      }
    }

    template {
      metadata {
        labels = {
          app = "servidor"
        }
      }

      spec {
        container {
          name  = "servidor"
          image = var.servidor_image

          port {
            container_port = var.container_port
          }

          resources {
            requests = {
              memory = "128Mi"
              cpu    = "250m"
            }
            limits = {
              memory = "256Mi"
              cpu    = "500m"
            }
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
      match_labels = {
        app = "cliente"
      }
    }

    template {
      metadata {
        labels = {
          app = "cliente"
        }
      }

      spec {
        container {
          name  = "cliente"
          image = var.cliente_image

          port {
            container_port = var.container_port
          }

          resources {
            requests = {
              memory = "128Mi"
              cpu    = "250m"
            }
            limits = {
              memory = "256Mi"
              cpu    = "500m"
            }
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "servidor_service" {
  metadata {
    name      = "servidor-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = "servidor"
    }

    port {
      port        = var.container_port
      target_port = var.container_port
    }

    type = "ClusterIP"
  }
}
