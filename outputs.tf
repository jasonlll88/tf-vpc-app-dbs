output "db_password" {
    value     = module.dbs_setup.db_password
    sensitive = true
}