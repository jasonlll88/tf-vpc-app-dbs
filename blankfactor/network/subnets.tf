# Create the subnets using a for_each loop
resource "aws_subnet" "jlrm_subnets" {
    for_each = var.subnet_cicd_az_name

    cidr_block = each.value.cidr_block
    vpc_id     = aws_vpc.jlrm_vpc.id

    availability_zone = each.value.availability_zone

    tags = {
        Name = each.key
    }
}