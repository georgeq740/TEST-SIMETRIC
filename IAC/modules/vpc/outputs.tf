# ID de la VPC
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

# IDs de subnets públicas
output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public_subnets[*].id
}

# IDs de subnets privadas
output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private_subnets[*].id
}


# ID del Internet Gateway
output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

# ID del NAT Gateway
output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = aws_nat_gateway.nat.id
}

output "public_subnets_by_az" {
  description = "Mapea los AZs a los IDs de las subnets públicas"
  value = {
    for idx, az in var.azs : az => aws_subnet.public_subnets[idx].id
  }
}

output "private_subnets_by_az" {
  description = "Mapea los AZs a los IDs de las subnets privadas"
  value = {
    for idx, az in var.azs : az => aws_subnet.private_subnets[idx].id
  }
}