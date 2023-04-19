# Global Vars
prefix_resources_name = "jlrm"
other_tags = {
    developer   = "Jheison Rodriguez"
    owner       = "Blankfactor"
}

# 01-Network Vars
vpc_cidr_block      = "10.0.0.0/16" # 65534 Ips

# Public and private subnets setup, 254 Ips
# the key of the map will be taken as the name for each subnet
subnet_cicd_az_name    = {
    public-1 = {cidr_block = "10.0.1.0/24", availability_zone = "us-east-1a"}, 
    public-2 = {cidr_block = "10.0.2.0/24", availability_zone = "us-east-1b"},
    public-3 = {cidr_block = "10.0.3.0/24", availability_zone = "us-east-1c"},
    private-1 = {cidr_block = "10.0.11.0/24", availability_zone = "us-east-1a"}, 
    private-2 = {cidr_block = "10.0.12.0/24", availability_zone = "us-east-1b"},
    private-3 = {cidr_block = "10.0.13.0/24", availability_zone = "us-east-1c"}
}


# 02-app Vars
asg_target_value    = 65.0
image_ami_id        = "ami-06e46074ae430fba6"
ec2_instance_type   = "t2.micro"

# 03-dbs Vars
rds_instance_class      = "db.t3.micro"
rds_allocated_storage   = 20
rds_username            = "postgres"
rds_db_name             = "id_table"
rds_public_access       = false
rds_skip_final_snapshot = true