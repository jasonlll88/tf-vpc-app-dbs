resource "aws_db_instance" "jlrm_rds_postgres" {
    identifier        = "${var.prefix_resources_name}-rds-postgres"
    engine            = "postgres"
    instance_class    = var.rds_instance_class
    allocated_storage = var.rds_allocated_storage
    storage_type      = "gp2"
    username          = var.rds_username
    # password is saved in secret manager
    password          = data.aws_secretsmanager_secret_version.db_password.secret_string
    db_name           = var.rds_db_name
    publicly_accessible = false
    db_subnet_group_name = aws_db_subnet_group.jrlm_rds_subnet_group.name
    vpc_security_group_ids = [aws_security_group.jlrm_db_sg.id]
    skip_final_snapshot  = true
    tags = merge(local.tags,{Name = "${var.prefix_resources_name}-rds-postgres"})          
}

resource "aws_db_subnet_group" "jrlm_rds_subnet_group" {
    name       = "${var.prefix_resources_name}-rds-subnet-group"
    subnet_ids = local.pri_subnets_ids
    tags = merge(local.tags,{Name = "${var.prefix_resources_name}-rds-subnet-group"})      
}

resource "aws_security_group" "jlrm_db_sg" {
    vpc_id      = var.vpc_id  
    name_prefix = "${var.prefix_resources_name}-db-sg"

    ingress {
        from_port = 5432
        to_port   = 5432
        protocol  = "tcp"
        security_groups = [var.jlrm_sg_ec2.id]
    }

    egress {
        from_port = 0
        to_port   = 0
        protocol  = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = merge(local.tags,{Name = "${var.prefix_resources_name}-db-sg"})         
}