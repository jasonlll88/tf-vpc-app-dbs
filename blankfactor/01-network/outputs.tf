output "jlrm_vpc_id" {
    value = aws_vpc.jlrm_vpc.id
}

output "jlrm_subnets" {
    value = {
        for name, subnet in aws_subnet.jlrm_subnets :
            name => {
                id = subnet.id
                cidr_block = subnet.cidr_block
                availability_zone = subnet.availability_zone
                name = subnet.tags.Name
        }
    }
}

output "jlrm_private_subnets" {
    value = local.private_subnets
}

output "jlrm_public_subnets" {
    value = local.public_subnets
}