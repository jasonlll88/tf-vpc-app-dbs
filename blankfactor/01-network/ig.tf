# Create the internet gateway
resource "aws_internet_gateway" "jlrm_igw" {
    vpc_id = aws_vpc.jlrm_vpc.id

    tags = merge(local.tags,{Name = "${var.prefix_resources_name}-ig"})    
}
