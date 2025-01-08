module "config" {
  source = "../modules/config"
}

module "vpc" {
  source        = "../modules/vpc"
  name          = "vpc-${terraform.workspace}"
  environment           = terraform.workspace
  account_id            = module.config.account_id
  region                = module.config.region
  vpc_cidr              = module.config.vpc_cidr
  public_subnet_cidrs   = module.config.public_subnet_cidrs
  private_subnet_cidrs  = module.config.private_subnet_cidrs
  azs                   = module.config.azs
  tags = {
    Project = "MyProject"
    Owner   = "Team"
    Env     = terraform.workspace
  }
}

module "eks" {
  source             = "../modules/eks"
  cluster_name       = "test-simetric"
  environment        = terraform.workspace
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  region             = module.config.region
}
