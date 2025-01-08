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


data "aws_eks_cluster_auth" "eks_auth" {
  name = module.eks.cluster_name
}

provider "kubernetes" {
  host                   = module.eks.eks_cluster_endpoint
  token                  = data.aws_eks_cluster_auth.eks_auth.token
  cluster_ca_certificate = base64decode(module.eks.eks_cluster_certificate)
}
