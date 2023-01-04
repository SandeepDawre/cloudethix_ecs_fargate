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

variable "availability_zone" {
  type = list(any)
}

variable "public_subnet_cidr" {
  type = list(any)
  #default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "private_subnet_cidr" {
  type = list(any)
  #default = ["10.0.3.0/24","10.0.4.0/24"]
}

variable "project" {
  type = string

}

variable "environment" {
  type = string

}
variable "tags" {
  default = {}
  type    = map(string)
}
