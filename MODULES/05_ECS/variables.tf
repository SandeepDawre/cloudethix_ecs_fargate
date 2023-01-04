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
variable "target_group_arn" {
  type = string
}
variable "container_name" {
  type = string
}
variable "container_port" {
  type = string
}
variable "private_subnets" {
  type = list(any)
}
variable "service_security_groups" {
  type = list(any)
}