locals {
  # Configuración centralizada por ambiente
  config = {
    dev = {
      account_id = "585768158376" 
      region = "us-east-1"
      vpc_cidr           = "10.3.0.0/16"
      public_subnet_cidrs  = ["10.3.1.0/24", "10.3.2.0/24"]
      private_subnet_cidrs = ["10.3.3.0/24", "10.3.4.0/24"]
      azs                  = ["us-east-1a", "us-east-1b"]
    }
    qa = {
      account_id = "585768158376" 
      region = "us-east-1"
      vpc_cidr           = "10.1.0.0/16"
      public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
      private_subnet_cidrs = ["10.1.3.0/24", "10.1.4.0/24"]
      azs                  = ["us-east-1a", "us-east-1b"]
    }
    staging = {
      account_id = "585768158376" 
      region = "us-east-1"
      vpc_cidr           = "10.2.0.0/16"
      public_subnet_cidrs  = ["10.2.1.0/24", "10.2.2.0/24"]
      private_subnet_cidrs = ["10.2.3.0/24", "10.2.4.0/24"]
      azs                  = ["us-east-1a", "us-east-1b"]
    }
    prod = {
      account_id = "585768158376" 
      region = "us-east-1"
      vpc_cidr           = "10.0.0.0/16"
      public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
      private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
      azs                  = ["us-east-1a", "us-east-1b"]
    }
  }
}