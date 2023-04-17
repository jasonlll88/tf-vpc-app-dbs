resource "random_password" "db_password" {
    length = 16
    special = true
}

resource "aws_db_instance" "jlrm_rds_postgres" {
    identifier        = "jlrm-rds-postgres"
    engine            = "postgres"
    instance_class    = "db.t3.micro"
    allocated_storage = 20
    storage_type      = "gp2"
    username          = "postgres"
    # password          = random_password.db_password.result
    password          = "postgres1234"
    db_name           = "first_db"
    publicly_accessible = false
    db_subnet_group_name = aws_db_subnet_group.jrlm_rds_subnet_group.name
    vpc_security_group_ids = [aws_security_group.jlrm_db_sg.id]
    skip_final_snapshot  = true
    tags = {
        Name = "jlrm-rds-postgres"
    }    
}

resource "aws_db_subnet_group" "jrlm_rds_subnet_group" {
    name       = "jlrm-rds-subnet-group"
    subnet_ids = local.pri_subnets_ids

    tags = {
        Name = "RDS Subnet Group"
    }
}

resource "aws_security_group" "jlrm_db_sg" {
    vpc_id      = var.vpc_id  
    name_prefix = "jlrm-db-sg"

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

    tags = {
        Name = "jlrm-db-sg"
    }         
}