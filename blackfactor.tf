module network_setup {
    source = "./blankfactor/01-network"
    vpc_cidr_block = var.vpc_cidr_block
    vpc_name = var.vpc_name
    subnet_cicd_az_name = var.subnet_cicd_az_name
}

module app_setup {
    source = "./blankfactor/02-app"
    vpc_id = module.network_setup.jlrm_vpc_id
    subnets = module.network_setup.jlrm_subnets
    public_subnets = module.network_setup.jlrm_public_subnets
    private_subnets = module.network_setup.jlrm_private_subnets

}

module dbs_setup {
    source = "./blankfactor/03-dbs"
    vpc_id = module.network_setup.jlrm_vpc_id
    subnets = module.network_setup.jlrm_subnets
    public_subnets = module.network_setup.jlrm_public_subnets
    private_subnets = module.network_setup.jlrm_private_subnets
    jlrm_sg_ec2 = module.app_setup.jlrm_sg_ec2
}