resource "aws_lb" "jlrm_alb" {
    name               = "jlrm-alb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.jlrm_alb_sg.id]
    subnets            = local.pub_subnets_ids

    tags = {
        Name = "jlrm-alb"  
    }
}

resource "aws_security_group" "jlrm_alb_sg" {
    name_prefix = "jlrm"
    vpc_id      = var.vpc_id   

    ingress {
        from_port = 80
        to_port   = 80
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port   = 0
        protocol  = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }    
    tags = {
        Name = "jlrm-alb-sg"
    }    
}

resource "aws_autoscaling_attachment" "jlrm_asg_a" {
    autoscaling_group_name = aws_autoscaling_group.jlrm_asg.name
    lb_target_group_arn   = aws_lb_target_group.jlrm_lb_tg.arn
}

resource "aws_alb_listener" "jlrm_alb_listener" {
    load_balancer_arn = aws_lb.jlrm_alb.arn
    port              = 80
    protocol          = "HTTP"
    
    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.jlrm_lb_tg.arn
    }
}
