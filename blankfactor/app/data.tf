data "aws_vpc" "jlrm_data_vpc" {
    filter {
        name   = "tag:Name"
        values = ["jlrm-nginx-app-vpc"]
    }    
}


data "aws_subnets" "jlrm_data_public_subnets" {
    filter {
        name   = "tag:Name"
        values = ["jlrm-public-*"]
    }     
}
