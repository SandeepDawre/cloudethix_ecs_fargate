//01_FOR VPC
variable "vpc_name" {
  type = string
}
variable "vpc_cidr_block" {
  type = string
}
variable "instance_tenancy" {
  type    = string
  default = "default"
}
variable "enable_dns_support" {
  type    = string
  default = "true"
}
variable "enable_dns_hostnames" {
  type    = string
  default = "true"
}
variable "public_subnet_cidr" {
  type = list(any)
  #default = ["10.0.1.0/24","10.0.2.0/24"]
}
variable "private_subnet_cidr" {
  type = list(any)
  #default = ["10.0.3.0/24","10.0.4.0/24"]
}
variable "availability_zone" {
  type = list(any)
}
variable "project" {
  type = string

}
variable "environment" {
  type = string
}

//02_ALB SG
variable "alb_sg_name" {
  type = string
}
variable "alb_description" {
  type = string
}
variable "alb_ingress_port" {
  type = list(any)
}
variable "alb_egress_port" {
  type = list(any)
}




//03_ALB
variable "alb_name" {
  type = string
}
variable "alb_internal" {
  type    = string
  default = "false"
}
variable "alb_type" {
  type = string
}
variable "alb_tg_name" {
  type = string
}


//04_SRV SG
variable "srv_sg_name" {
  type = string
}
variable "srv_description" {
  type = string
}
variable "srv_ingress_port" {
  type = list(any)
}
variable "srv_egress_port" {
  type = list(any)
}

//05 ECR REPO
variable "ecr_name" {
  type = string
}

//06 ECS 

variable "ecs_name" {
  type = string
}
variable "task_def_name" {
  type = string
}
variable "task_cpu" {
  type = number
}
variable "task_mem" {
  type = number
}
variable "container_definitions" {
  type = list(any)
}
variable "ecs_iam_role_name" {
  type = string
}
variable "ecs_service_name" {
  type = string
}
variable "container_name" {
  type = string
}
variable "container_port" {
  type = string
}
