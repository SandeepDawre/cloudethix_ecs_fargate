//FOR VPC
vpc_name             = "cloudethix-vpc"
vpc_cidr_block       = "10.0.0.0/16"
instance_tenancy     = "default"
enable_dns_support   = "true"
enable_dns_hostnames = "true"
public_subnet_cidr   = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidr  = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zone    = ["us-east-1a", "us-east-1b"]
project              = "cloudethix-tf"
environment          = "Dev"


//FOR ALB SG
alb_sg_name      = "alb-sg"
alb_description  = "alb-sg"
alb_ingress_port = ["80"]
alb_egress_port  = ["80"]


//FOR ALB
alb_name     = "cloudethix-alb"
alb_internal = "false"
alb_type     = "application"
alb_tg_name  = "cloudethix-tg"

//FOR SERVICE SG
srv_sg_name      = "srv-sg"
srv_description  = "srv-sg"
srv_ingress_port = ["80"]
srv_egress_port  = ["80"]

//FOR ECR REPO
ecr_name = "cloudethix-ecr-repo"


//FOR ECS
ecs_name          = "cloudethix-ecs-cluster"
task_def_name     = "cloudethix-task-def"
task_cpu          = 256
task_mem          = 512
ecs_iam_role_name = "cloudethix-iam-role"
ecs_service_name  = "nginx-service"
container_name    = "nginx"
container_port    = "80"
container_definitions = [
  {
    "name" : "nginx",
    "image" : "182263511292.dkr.ecr.us-east-1.amazonaws.com/cloudethix-ecr-repo:latest",
    "memory" : 512,
    "cpu" : 256,
    "essential" : true,
    "portMappings" : [
      {
        "containerPort" : 80,
        "protocol" : "tcp"
      }
    ],
    "logConfiguration" : {
      "logDriver" : "awslogs",
      "options" : {
        "awslogs-create-group" : "true",
        "awslogs-group" : "awslogs-nginx-ecs",
        "awslogs-region" : "us-east-1",
        "awslogs-stream-prefix" : "ecs"
      }
    }
  }
]