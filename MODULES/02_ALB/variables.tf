
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

variable "alb_security_groups" {
  type = list(string)
}

variable "alb_subnets" {
  type = list(string)
}

variable "alb_tg_name" {
  type = string
}

variable "vpc_id" {
  type = string
}