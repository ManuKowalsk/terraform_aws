variable "parameters" {
    type = list(object({
        name = string
        SubId = string
    }))
}

variable "ec2_security_group_id" {
    type = string
}


variable "db_name"{}

variable "db_username"{}

variable "db_password"{}

variable "db_endpoint"{}