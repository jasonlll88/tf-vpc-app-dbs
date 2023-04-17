module network_setup {
    source = "./blankfactor/network"
    vpc_cidr_block = var.vpc_cidr_block
    vpc_name = var.vpc_name
    subnet_cicd_az_name = var.subnet_cicd_az_name
}

module app_setup {
    source = "./blankfactor/app"

}

module dbs_setup {
    source = "./blankfactor/dbs"

}