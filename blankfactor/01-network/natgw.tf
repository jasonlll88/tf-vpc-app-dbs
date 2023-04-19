# # Create the NAT gateways and attach them to the private subnets
resource "aws_nat_gateway" "jlrm_nat_gateway" {

    count = length(keys(local.private_subnets))

    allocation_id = aws_eip.jlrm_eip[count.index].id
    subnet_id     = aws_subnet.jlrm_subnets[keys(local.private_subnets)[count.index]].id

    depends_on = [
        aws_eip.jlrm_eip,
        aws_subnet.jlrm_subnets,
    ]

    tags = merge(local.tags,{Name = "${var.prefix_resources_name}-natgw"})      
}

# Create an Elastic IP address for the NAT gateways
resource "aws_eip" "jlrm_eip" {
    count = length(local.private_subnets)
    vpc   = true

    tags = merge(local.tags,{Name = "${var.prefix_resources_name}-eip"})         
}

# Create a route in the private route table for the NAT gateway
resource "aws_route" "jlrm_private_nat_route" {

    count = length(keys(local.private_subnets))
    
    route_table_id            = aws_route_table.jlrm_private_rt[count.index].id
    destination_cidr_block    = "0.0.0.0/0"
    nat_gateway_id            = aws_nat_gateway.jlrm_nat_gateway[count.index].id

    depends_on = [
        aws_route_table.jlrm_private_rt,
        aws_nat_gateway.jlrm_nat_gateway
    ]

}
