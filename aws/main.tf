terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"
  shared_credentials_file = var.aws_cred_file
  profile                 = var.aws_cred_profile
}

provider "random" {
  version = "~> 2.1"
}

provider "local" {
  version = "~> 1.2"
}

provider "null" {
  version = "~> 2.1"
}

provider "template" {
  version = "~> 2.1"
}

data "aws_availability_zones" "available" {
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

locals {
  cluster_name = "eugene-eks-${random_string.suffix.result}"
  my_ip = "${chomp(data.http.myip.body)}/32"
}




# Create a VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eugene-vpc"
  cidr = "10.0.0.0/16"

  azs             = data.aws_availability_zones.available.names
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
  tags = {
    Terraform = "true"
    Environment = "eugene"
  }
}


#############
# RDS Aurora
#############
module "aurora" {
  source                              = "terraform-aws-modules/rds-aurora/aws"
  version                             = "~> 3.0"
  name                                = "aurora-eugene-mysql"
  engine                              = "aurora-mysql"
  engine_version                      = "5.7.12"
  #db_subnet_group_name                = aws_db_subnet_group.aurora_db_subnet_group.id
  subnets                             = module.vpc.public_subnets
  vpc_id                              = module.vpc.vpc_id
  replica_count                       = 1
  instance_type                       = "db.t3.small"
  password                            = random_password.master.result
  create_random_password              = false
  apply_immediately                   = true
  skip_final_snapshot                 = true
  db_parameter_group_name             = aws_db_parameter_group.aurora_db_57_parameter_group.id
  db_cluster_parameter_group_name     = aws_rds_cluster_parameter_group.aurora_57_cluster_parameter_group.id
  # iam_database_authentication_enabled = true
  # enabled_cloudwatch_logs_exports     = ["audit", "error", "general", "slowquery"]
  allowed_cidr_blocks                 = concat(module.vpc.private_subnets_cidr_blocks, [local.my_ip])

  create_security_group = true
  publicly_accessible = true
}
resource "random_password" "master" {
  length = 16
  min_upper = 1
  min_lower = 1
  min_special = 1
  override_special = ":@.,/+-!="
}
resource "aws_db_parameter_group" "aurora_db_57_parameter_group" {
  name        = "dev-aurora-db-57-parameter-group"
  family      = "aurora-mysql5.7"
  description = "dev-aurora-db-57-parameter-group"
}
resource "aws_rds_cluster_parameter_group" "aurora_57_cluster_parameter_group" {
  name        = "dev-aurora-57-cluster-parameter-group"
  family      = "aurora-mysql5.7"
  description = "dev-aurora-57-cluster-parameter-group"
}

resource "aws_db_subnet_group" "aurora_db_subnet_group" {
  subnet_ids = module.vpc.public_subnets
}

############################
# Mysql of security group
############################
resource "aws_security_group" "app_servers" {
  name_prefix = "app-servers-"
  description = "For application servers"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "allow_access" {
  type                     = "ingress"
  from_port                = module.aurora.this_rds_cluster_port
  to_port                  = module.aurora.this_rds_cluster_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app_servers.id
  security_group_id        = module.aurora.this_security_group_id
}

###########
# MySQL data
###########
resource "time_sleep" "wait_2_minutes" {
  depends_on = [module.aurora]
  create_duration = "2m"
}
resource "null_resource" "db_setup1" {
  depends_on = [time_sleep.wait_2_minutes]
  provisioner "local-exec" {
    command = "/usr/local/bin/mysql -u ${module.aurora.this_rds_cluster_master_username} -p'${module.aurora.this_rds_cluster_master_password}' -h ${module.aurora.this_rds_cluster_endpoint} < db_backup.sql" 
  }

}

######
# ECR
######
resource "aws_ecr_repository" "eugene-app" {
  name                 = "eugene-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

######
# EKS
######

resource "random_string" "suffix" {
  length  = 8
  special = false
}

resource "aws_security_group" "worker_group_mgmt" {
  name_prefix = "worker_group_mgmt"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      local.my_ip,
    ]
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.11"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = local.cluster_name
  cluster_version = "1.18"
  subnets         = module.vpc.private_subnets

  tags = {
    Environment = "eugene"
    Terraform = "true"
  }

  vpc_id = module.vpc.vpc_id

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t3.small"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.worker_group_mgmt.id, aws_security_group.app_servers.id]
      root_volume_type              = "gp2"
    },
  ]
}

resource "kubernetes_config_map" "db_connect" {
  metadata {
    name = "db-connect"
  }

  data = {
    db_host = module.aurora.this_rds_cluster_endpoint
    db_user = module.aurora.this_rds_cluster_master_username
  }
}

resource "kubernetes_secret" "db_pwd" {
  metadata {
    name = "db-pwd"
  }

  data = {
    db_pwd = module.aurora.this_rds_cluster_master_password
  }

  type = "Opaque"
}
