locals {
    private_subnets = {
        # for k, v in var.subnet_cicd_az_name : k => v if startswith(k, "${var.prefix_resources_name}-private")
        for k, v in aws_subnet.jlrm_subnets : k => v if startswith(v.tags.Name, "${var.prefix_resources_name}-private")
    }

    public_subnets = {
        # for k, v in var.subnet_cicd_az_name : k => v if substr(k, 5, 7) == "public"
        for k, v in aws_subnet.jlrm_subnets : k => v if startswith(v.tags.Name, "${var.prefix_resources_name}-public")
    }

    tags = merge(var.other_tags, {
        terraformRepo       = "https://github.com/jasonlll88/tf-vpc-app-dbs.git"
        terraformModulePath = "blankfactor/01-network"
    })
}
