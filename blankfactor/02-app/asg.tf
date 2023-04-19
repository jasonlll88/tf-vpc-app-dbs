resource "aws_autoscaling_group" "jlrm_asg" {
    name                 = "${var.prefix_resources_name}-asg"
    launch_template {
        id = aws_launch_template.jlrm_launch_template.id
        version = "$Latest"
    }
    vpc_zone_identifier  = local.pub_subnets_ids
    target_group_arns    = [aws_lb_target_group.jlrm_lb_tg.arn]
    min_size             = 1
    max_size             = 5
    health_check_type    = "ELB"
    health_check_grace_period = 300
    termination_policies = ["OldestInstance", "Default"] 
}


resource "aws_lb_target_group" "jlrm_lb_tg" {
    name_prefix = "${var.prefix_resources_name}"
    port        = 80
    protocol    = "HTTP"
    vpc_id      = var.vpc_id
    
    tags = merge(local.tags,{Name = "${var.prefix_resources_name}-lb-tg"})

}

resource "aws_autoscaling_policy" "jlrm_asg_policy" {
    name                   = "${var.prefix_resources_name}-asg-policy"
    policy_type            = "TargetTrackingScaling"
    estimated_instance_warmup = 60
    autoscaling_group_name = aws_autoscaling_group.jlrm_asg.name

    target_tracking_configuration {
        predefined_metric_specification {
        predefined_metric_type = "ASGAverageCPUUtilization"
        }
        target_value = var.asg_target_value
    }     
}

