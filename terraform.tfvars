# Global Vars
prefix_resources_name = "jlrm"
other_tags = {
    developer   = "Jheison Rodriguez"
    owner       = "Blankfactor"
}




# 01-Network Vars
vpc_name        = "nginx-app-vpc"
vpc_cidr_block      = "10.0.0.0/16" # 65534 Ips

# Public and private subnets setup, 254 Ips
subnet_cicd_az_name    = {
    jlrm-public-1 = {cidr_block = "10.0.1.0/24", availability_zone = "us-east-1a"}, 
    jlrm-public-2 = {cidr_block = "10.0.2.0/24", availability_zone = "us-east-1b"},
    jlrm-public-3 = {cidr_block = "10.0.3.0/24", availability_zone = "us-east-1c"},
    jlrm-private-1 = {cidr_block = "10.0.11.0/24", availability_zone = "us-east-1a"}, 
    jlrm-private-2 = {cidr_block = "10.0.12.0/24", availability_zone = "us-east-1b"},
    jlrm-private-3 = {cidr_block = "10.0.13.0/24", availability_zone = "us-east-1c"}
}



# 02-app Vars



# 03-dbs Vars