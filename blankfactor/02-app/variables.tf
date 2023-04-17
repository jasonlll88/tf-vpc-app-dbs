variable "vpc_id" {
    type = string
}

variable "subnets" {
    type = map
}

variable "public_subnets" {

}

variable "private_subnets" {

}

locals {
    pub_subnets_ids = values({
        for subnet_name, subnet_config in var.subnets :
        subnet_name => subnet_config.id
        if startswith(subnet_config.name, "jlrm-public")
    })

    pri_subnets_ids = values({
        for subnet_name, subnet_config in var.subnets :
        subnet_name => subnet_config.id
        if startswith(subnet_config.name, "jlrm-private")
    })
}