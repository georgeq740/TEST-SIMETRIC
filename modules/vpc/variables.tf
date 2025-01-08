# Nombre base de los recursos
variable "name" {
  description = "Name of the VPC"
  type        = string
}

# Ambiente (dev, staging, prod)
variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of 'dev', 'staging', or 'prod'."
  }
}

# ID de la cuenta de AWS
variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

# Región de AWS
variable "region" {
  description = "AWS Region"
  type        = string
}

# CIDR para la VPC
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

# Lista de tags comunes
variable "tags" {
  description = "Default tags for all resources"
  type        = map(string)
  default     = {}
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  # No validation here since it can't reference var.azs
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  # No validation here since it can't reference var.azs
}

variable "azs" {
  description = "List of Availability Zones"
  type        = list(string)
}
