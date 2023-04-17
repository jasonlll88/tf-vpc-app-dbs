# Create the internet gateway
resource "aws_internet_gateway" "jlrm_igw" {
    vpc_id = aws_vpc.jlrm_vpc.id

    tags = {
        Name = "jlrm-ig"
    }
}
