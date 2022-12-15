provider "aws" {
  version = "~> 3.0"
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
}

module "elb" {
  source = "./modules/elb"
  load_balancer_sg = module.vpc.load_balancer_sg
  load_balancer_subnet_a = module.vpc.load_balancer_subnet_a
  load_balancer_subnet_b = module.vpc.load_balancer_subnet_b
  load_balancer_subnet_c = module.vpc.load_balancer_subnet_c
  vpc = module.vpc.vpc
}

module "iam" {
  source = "./modules/iam"
  elb = module.elb.elb
  sidekiq-elb = module.elb.sidekiq-elb
  blockchain-elb = module.elb.blockchain-elb
}

module "ecs" {
  source = "./modules/ecs"
  ecs_role = module.iam.ecs_role
  ecs_sg = module.vpc.ecs_sg
  ecs_subnet_a = module.vpc.ecs_subnet_a
  ecs_subnet_b = module.vpc.ecs_subnet_b
  ecs_subnet_c = module.vpc.ecs_subnet_c
  ecs_target_group = module.elb.ecs_target_group
  sidekiq_target_group = module.elb.sidekiq_target_group
  blockchain_target_group = module.elb.blockchain_target_group
  ecr_repository = module.ecr.ecr_repository
  sidekiq_ecr_repository = module.ecr.sidekiq_ecr_repository
  blockchain_ecr_repository = module.ecr.blockchain_ecr_repository
  log_group = module.cloudwatch.log_group
  sidekiq_log_group = module.cloudwatch.sidekiq_log_group
  blockchain_log_group = module.cloudwatch.blockchain_log_group 
  region = var.region
}

module "ecr" {
  source = "./modules/ecr"
}

module "auto_scaling" {
  source = "./modules/auto-scaling"
  ecs_cluster = module.ecs.ecs_cluster
  ecs_service = module.ecs.ecs_service
  sidekiq_ecs_service = module.ecs.sidekiq_ecs_service
  blockchain_ecs_service = module.ecs.blockchain_ecs_service
}

module "rds" {
  source = "./modules/rds"
  vpc = module.vpc.vpc
  rds_password = var.rds_password
  rds_sg = module.vpc.rds_sg
  ecs_subnet_a = module.vpc.ecs_subnet_a
  ecs_subnet_b = module.vpc.ecs_subnet_b
  ecs_subnet_c = module.vpc.ecs_subnet_c
  
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
}

module "elasticcache" {
  source = "./modules/elasticcache"
  elasticache_sg = module.vpc.elasticache_sg
  ecs_subnet_a = module.vpc.ecs_subnet_a
  ecs_subnet_b = module.vpc.ecs_subnet_b
  ecs_subnet_c = module.vpc.ecs_subnet_c
}

module "docudb" {
  source = "./modules/documentdb"
  vpc = module.vpc.vpc
  docudb_password = var.docudb_password
  docudb_sg = module.vpc.docudb_sg
  ecs_subnet_a = module.vpc.ecs_subnet_a
  ecs_subnet_b = module.vpc.ecs_subnet_b
  ecs_subnet_c = module.vpc.ecs_subnet_c
  
}