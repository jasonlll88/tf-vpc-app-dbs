output "vpc_id" {
    value = module.network_setup.jlrm_vpc_id
}
output "vpc_subnets" {
    value = module.network_setup.jlrm_subnets
}

output "alb" {
    value = module.app_setup.jlrm_alb.dns_name
}