output "vpc_cidr" {
  value = local.config[terraform.workspace].vpc_cidr
}

output "public_subnet_cidrs" {
  value = local.config[terraform.workspace].public_subnet_cidrs
}

output "private_subnet_cidrs" {
  value = local.config[terraform.workspace].private_subnet_cidrs
}

output "azs" {
  value = local.config[terraform.workspace].azs
}

output "region" {
  value = local.config[terraform.workspace].region
}

output "account_id" {
  value = local.config[terraform.workspace].account_id
}