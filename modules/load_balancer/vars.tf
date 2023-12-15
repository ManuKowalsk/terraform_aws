variable subnet_id_list{
    type = list(string)
}

variable "loadbalancer_security_group" {
    type = string
}

variable "vpc_id" {}

variable "instances_id"{}