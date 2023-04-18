locals {
    private_subnets = {
        for k, v in var.subnet_cicd_az_name : k => v if substr(k, 5, 7) == "private"
    }

    public_subnets = {
        for k, v in var.subnet_cicd_az_name : k => v if substr(k, 5, 7) == "public"
    }

    tags = merge(var.other_tags, {
        terraformRepo       = "https://github.com/jasonlll88/tf-vpc-app-dbs.git"
        terraformModulePath = "blankfactor/01-network"
    })
}
