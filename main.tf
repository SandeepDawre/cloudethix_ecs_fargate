module "vpc" {
  source               = "./MODULES/01_VPC"
  vpc_name             = var.vpc_name
  vpc_cidr_block       = var.vpc_cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  public_subnet_cidr   = var.public_subnet_cidr
  private_subnet_cidr  = var.private_subnet_cidr
  availability_zone    = var.availability_zone
  project              = var.project
  environment          = var.environment
}


module "alb_security_group" {
  source       = "./MODULES/03_SECURITY_GROUP"
  sg_name      = var.alb_sg_name
  description  = var.alb_description
  ingress_port = var.alb_ingress_port
  egress_port  = var.alb_egress_port
  vpc_id       = module.vpc.vpc_id
}

module "alb" {
  source              = "./MODULES/02_ALB"
  alb_name            = var.alb_name
  alb_internal        = var.alb_internal
  alb_type            = var.alb_type
  alb_tg_name         = var.alb_tg_name
  alb_security_groups = [module.alb_security_group.security_group_id]
  alb_subnets         = module.vpc.public_subnet_ids
  vpc_id              = module.vpc.vpc_id
}


module "srv_security_group" {
  source       = "./MODULES/03_SECURITY_GROUP"
  sg_name      = var.srv_sg_name
  description  = var.srv_description
  ingress_port = var.srv_ingress_port
  egress_port  = var.srv_egress_port
  vpc_id       = module.vpc.vpc_id
}



module "ecr_repo" {
  source   = "./MODULES/04_ECR_REPO/"
  ecr_name = var.ecr_name
}


module "task_def" {
  source                  = "./MODULES/05_ECS/"
  ecs_name                = var.ecs_name
  task_def_name           = var.task_def_name
  task_cpu                = var.task_cpu
  task_mem                = var.task_mem
  container_definitions   = var.container_definitions
  ecs_iam_role_name       = var.ecs_iam_role_name
  ecs_service_name        = var.ecs_service_name
  container_name          = var.container_name
  container_port          = var.container_port
  target_group_arn        = module.alb.target_group_arn
  private_subnets         = module.vpc.private_subnet_ids
  service_security_groups = [module.srv_security_group.security_group_id]
}
