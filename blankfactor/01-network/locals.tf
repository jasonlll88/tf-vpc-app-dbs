locals {
    private_subnets = {
        for k, v in var.subnet_cicd_az_name : k => v if substr(k, 5, 7) == "private"
    }

    public_subnets = {
        for k, v in var.subnet_cicd_az_name : k => v if substr(k, 5, 7) == "public"
    }
}
