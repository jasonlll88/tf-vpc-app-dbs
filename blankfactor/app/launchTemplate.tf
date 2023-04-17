resource "aws_key_pair" "jlrm_key_pair" {
    key_name   = "jlrm-key-pair"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCpwi8k+M3ljgYykdYr9KmVRNeWkZZivxwTKQv3Vo3New82sDlYt74Sz5anNWIAorprpF8xZzBGg1a96xvjfzoGiUxB77W/DHeLvvvLAvjoYKdjUBzFAVGgrsSUUGTH8yJtO6HLwXg2wmHgF1cQHzQVQd//TFYFVvwgOgXvyEBdrunlPjhATT5/J1eybc9kNo0Lo3ebmdAslVn3pZGH6YDLARnDf5PXk4FeUW+86dDgPtR7d1TdPlVLqLG7QCxt82FUWVA7jZ8lZx6++b/cxKVPinbtCFqfs4mgH90+6WFAmcsju28CL+Zmxk5e1K2YfsUNW36oxEZLIQuNStTvB4d1 ngingx-keypair"
    tags = {
        Name = "jlrm-key-pair"
    }
}

resource "aws_launch_template" "jlrm_launch_template" {
    name_prefix             = "jlrm-app-nginx-launch-template"
    image_id                = "ami-06e46074ae430fba6" # amazon linux
    instance_type           = "t2.micro"
    key_name                = "jlrm-key-pair"
    update_default_version=true

    # Configure user data to install any software or configuration
    user_data = filebase64("blankfactor/app/user-data.sh")

    iam_instance_profile {
        name = "jlrm-instance-profile"
    }

    block_device_mappings {
        device_name = "/dev/xvda"
        ebs {
        volume_size = 8
        }
    }

    network_interfaces {
        associate_public_ip_address     = true
        subnet_id                       = data.aws_subnets.jlrm_data_public_subnets.ids[0]
        security_groups                 = [aws_security_group.instance_sg.id]
    }    

    tag_specifications {
        resource_type = "instance"
        tags = {
        Name = "jlrm-app-nginx-launch-template"
        }
    }
    tags = {
        Name = "jlrm-app-nginx-launch-template"
    }      
}

resource "aws_security_group" "instance_sg" {
    vpc_id      = data.aws_vpc.jlrm_data_vpc.id   
    name_prefix = "jlrm-instance-sg"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port   = 80
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "jlrm-sg-ec2-instance"
    }         
}

resource "aws_iam_instance_profile" "jlrm_instance_profile" {
    name = "jlrm-instance-profile"
    role = aws_iam_role.jlrm_instance_profile_role.name

    tags = {
        Name = "jlrm-instance-profile"
    }    
}

resource "aws_iam_role" "jlrm_instance_profile_role" {
    name = "jlrm-instance-profile-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
            Service = "ec2.amazonaws.com"
            }
        }
        ]
    })
    tags = {
        Name = "jlrm-instance-profile-role"
    }
}

