# define a VPC with CIDR 
resource "aws_vpc" "jlrm_vpc" {
    cidr_block = var.vpc_cidr_block

    tags = merge(local.tags,{name = "${var.prefix_resources_name}-vpc"})

}
