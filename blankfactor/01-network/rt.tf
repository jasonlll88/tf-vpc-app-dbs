# Create the public route table
resource "aws_route_table" "jlrm_public_rt" {
    vpc_id = aws_vpc.jlrm_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.jlrm_igw.id
    }

    tags = merge(local.tags,{Name = "${var.prefix_resources_name}-public-rt"})  
}

# Associate the public subnets with the public route table
resource "aws_route_table_association" "jlrm_public_rta" {
    for_each = local.public_subnets

    subnet_id      = aws_subnet.jlrm_subnets[each.key].id
    route_table_id = aws_route_table.jlrm_public_rt.id

    depends_on = [
        aws_route_table.jlrm_public_rt,
        aws_subnet.jlrm_subnets,
        aws_internet_gateway.jlrm_igw,
    ]
}

# Create the private route table
resource "aws_route_table" "jlrm_private_rt" {
    count = length(local.private_subnets)
    vpc_id = aws_vpc.jlrm_vpc.id

    depends_on = [
        aws_vpc.jlrm_vpc,
    ]

    tags = merge(local.tags,{Name = "${var.prefix_resources_name}-private-rt"})          
}


# Associate the private subnets with the private route table
resource "aws_route_table_association" "jlrm_private_rta" {
    count = length(keys(local.private_subnets))

    subnet_id      = aws_subnet.jlrm_subnets[keys(local.private_subnets)[count.index]].id
    route_table_id = aws_route_table.jlrm_private_rt[count.index].id

    depends_on = [
        aws_route_table.jlrm_private_rt,
        aws_subnet.jlrm_subnets,
        aws_internet_gateway.jlrm_igw,
    ]
}