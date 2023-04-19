locals {
    pub_subnets_ids = values({
        for subnet_name, subnet_config in var.subnets :
        subnet_name => subnet_config.id
        if startswith(subnet_config.name, "${var.prefix_resources_name}-public")
    })

    pri_subnets_ids = values({
        for subnet_name, subnet_config in var.subnets :
        subnet_name => subnet_config.id
        if startswith(subnet_config.name, "${var.prefix_resources_name}-private")
    })

    tags = merge(var.other_tags, {
        terraformRepo       = "https://github.com/jasonlll88/tf-vpc-app-dbs.git"
        terraformModulePath = "blankfactor/02-app"
    })    
}
