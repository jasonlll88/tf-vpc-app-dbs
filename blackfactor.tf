module network_setup {
    source                  = "./blankfactor/01-network"
    
    other_tags              = var.other_tags
    vpc_cidr_block          = var.vpc_cidr_block
    subnet_cicd_az_name     = var.subnet_cicd_az_name
    prefix_resources_name   = var.prefix_resources_name
}

module app_setup {
    source                  = "./blankfactor/02-app"

    vpc_id                  = module.network_setup.jlrm_vpc_id
    subnets                 = module.network_setup.jlrm_subnets
    public_subnets          = module.network_setup.jlrm_public_subnets
    private_subnets         = module.network_setup.jlrm_private_subnets
    
    other_tags              = var.other_tags    
    prefix_resources_name   = var.prefix_resources_name
    asg_target_value        = var.asg_target_value
    ec2_instance_type       = var.ec2_instance_type
    image_ami_id            = var.image_ami_id
}

module dbs_setup {
    source                  = "./blankfactor/03-dbs"

    vpc_id                  = module.network_setup.jlrm_vpc_id
    subnets                 = module.network_setup.jlrm_subnets
    public_subnets          = module.network_setup.jlrm_public_subnets
    private_subnets         = module.network_setup.jlrm_private_subnets
    jlrm_sg_ec2             = module.app_setup.jlrm_sg_ec2

    other_tags              = var.other_tags
    prefix_resources_name   = var.prefix_resources_name
    rds_instance_class      = var.rds_instance_class
    rds_allocated_storage   = var.rds_allocated_storage
    rds_username            = var.rds_username
    rds_db_name             = var.rds_db_name
    rds_public_access       = var.rds_public_access
    rds_skip_final_snapshot = var.rds_skip_final_snapshot
}