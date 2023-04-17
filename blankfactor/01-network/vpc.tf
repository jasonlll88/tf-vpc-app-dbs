# define a VPC with CIDR 
resource "aws_vpc" "jlrm_vpc" {
    cidr_block = var.vpc_cidr_block

    tags = {
        Name = var.vpc_name
    }

}
