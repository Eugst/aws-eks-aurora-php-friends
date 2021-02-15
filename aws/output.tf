# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

# NAT gateways
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

# AZs
output "azs" {
  description = "A list of availability zones spefified as argument to this module"
  value       = module.vpc.azs
}

# Aurora
output "aurora_cluster_id" {
  description = "The ID of the cluster"
  value       = module.aurora.this_rds_cluster_id
}

output "aurora_cluster_resource_id" {
  description = "The Resource ID of the cluster"
  value       = module.aurora.this_rds_cluster_resource_id
}

output "aurora_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = module.aurora.this_rds_cluster_endpoint
}

output "aurora_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = module.aurora.this_rds_cluster_reader_endpoint
}

output "aurora_cluster_database_name" {
  description = "Name for an automatically created database on cluster creation"
  value       = module.aurora.this_rds_cluster_database_name
}

output "aurora_cluster_master_password" {
  description = "The master password"
  value       = module.aurora.this_rds_cluster_master_password
  sensitive   = true
}

output "aurora_cluster_port" {
  description = "The port"
  value       = module.aurora.this_rds_cluster_port
}

output "aurora_cluster_master_username" {
  description = "The master username"
  value       = module.aurora.this_rds_cluster_master_username
}

# aws_rds_cluster_instance
output "aurora_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = module.aurora.this_rds_cluster_instance_endpoints
}

output "aurora_cluster_instance_ids" {
  description = "A list of all cluster instance ids"
  value       = module.aurora.this_rds_cluster_instance_ids
}

# aws_security_group
output "this_security_group_id" {
  description = "The security group ID of the cluster"
  value       = module.aurora.this_security_group_id
}



#EKS

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.eks.cluster_security_group_id
}

output "kubectl_config" {
  description = "kubectl config as generated by the module."
  value       = module.eks.kubeconfig
}

output "config_map_aws_auth" {
  description = "A kubernetes configuration to authenticate to this EKS cluster."
  value       = module.eks.config_map_aws_auth
}
