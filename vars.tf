variable vpc_cidr {
    type = string 
}

variable vpc_name {
  type        = string
}

variable subnets_cidr {
  type = list
}

variable "ports" {
    type = list
}

variable "cidr_blocks" {
    type = list
}

variable "key_name" {
    type = string
}

variable "instance_type" {
    type = string
}

variable "ami_id" {
    type = string
}

variable "username" {
    type = string
}

variable "password" {
    type = string
}

