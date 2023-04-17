resource "aws_autoscaling_group" "jlrm_asg" {
    name                 = "jlrm-asg"
    launch_template {
        id = aws_launch_template.jlrm_launch_template.id
        version = "$Latest"
    }
    vpc_zone_identifier  = data.aws_subnets.jlrm_data_public_subnets.ids
    target_group_arns    = [aws_lb_target_group.jlrm_lb_tg.arn]
    min_size             = 1
    max_size             = 5
    health_check_type    = "ELB"
    health_check_grace_period = 300
    termination_policies = ["OldestInstance", "Default"]
}

resource "aws_lb_target_group" "jlrm_lb_tg" {
    name_prefix = "jlrm"
    port        = 80
    protocol    = "HTTP"
    vpc_id      = data.aws_vpc.jlrm_data_vpc.id
    
    tags = {
        Name = "jlrm-lb-tg"
    }      
}


