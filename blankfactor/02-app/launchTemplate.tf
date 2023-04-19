resource "aws_launch_template" "jlrm_launch_template" {
    name_prefix             = "${var.prefix_resources_name}-app-nginx-launch-template"
    image_id                = var.image_ami_id
    instance_type           = var.ec2_instance_type
    update_default_version  = true

    # Configure user data to install any software or configuration
    user_data = filebase64("blankfactor/02-app/files/user-data.sh")

    iam_instance_profile {
        name = aws_iam_instance_profile.jlrm_instance_profile.name
    }

    metadata_options {
        http_endpoint = "enabled"
        http_tokens   = "required"
    }    

    block_device_mappings {
        device_name = "/dev/xvda"
        ebs {
        volume_size = 8
        }
    }

    network_interfaces {
        associate_public_ip_address     = true
        subnet_id                       = local.pub_subnets_ids[0]
        security_groups                 = [aws_security_group.instance_sg.id]
    }    

    tag_specifications {
        resource_type   = "instance"
        tags            = merge(local.tags,{Name = "${var.prefix_resources_name}-app-nginx-launch-template"}) 
    }

    tags = merge(local.tags,{Name = "${var.prefix_resources_name}-app-nginx-launch-template"})           
}

resource "aws_security_group" "instance_sg" {
    vpc_id      = var.vpc_id   
    name_prefix = "${var.prefix_resources_name}-sg-ec2-instance"

    ingress {
        from_port = 80
        to_port   = 80
        protocol  = "tcp"
        security_groups = [aws_security_group.jlrm_alb_sg.id]
    }    

    egress {
        from_port = 0
        to_port   = 0
        protocol  = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = merge(local.tags,{Name = "${var.prefix_resources_name}-sg-ec2-instance"})            
}

resource "aws_iam_instance_profile" "jlrm_instance_profile" {
    name = "${var.prefix_resources_name}-instance-profile"
    role = aws_iam_role.jlrm_instance_profile_role.name
    tags = merge(local.tags,{Name = "${var.prefix_resources_name}-nstance-profile"})        
}

resource "aws_iam_role" "jlrm_instance_profile_role" {
    name = "${var.prefix_resources_name}-instance-profile-role"
    assume_role_policy = file("blankfactor/02-app/files/instance-role-trust-relationship.json")
    tags = merge(local.tags,{Name = "${var.prefix_resources_name}-instance-profile-role"})     
}

resource "aws_iam_policy" "jlrm_iam_policy" {
  name        = "${var.prefix_resources_name}-instance-profile-policy"
  description = "policy for SSM"

  policy = file("blankfactor/02-app/files/instance-role-policy.json")
  tags = merge(local.tags,{Name = "${var.prefix_resources_name}-instance-profile-policy"}) 
}

resource "aws_iam_role_policy_attachment" "jlrm_iam_role_pol_attach" {
  policy_arn = aws_iam_policy.jlrm_iam_policy.arn
  role       = aws_iam_role.jlrm_instance_profile_role.name
}