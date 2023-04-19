resource "aws_lb" "jlrm_alb" {
    name               = "${var.prefix_resources_name}-alb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.jlrm_alb_sg.id]
    subnets            = local.pub_subnets_ids

    tags = merge(local.tags,{Name = "${var.prefix_resources_name}-alb"})

}

resource "aws_security_group" "jlrm_alb_sg" {
    name_prefix = "${var.prefix_resources_name}"
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

    tags = merge(local.tags,{Name = "${var.prefix_resources_name}-alb-sg"})         
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

# # Uncomment to enable HTTPS on the alb
# resource "aws_lb_listener" "https" {
#     load_balancer_arn = aws_lb.jlrm_alb.arn
#     port              = 443
#     protocol          = "HTTPS"
#     ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"

#     certificate_arn = data.aws_acm_certificate.amazon_issued.arn

#     default_action {
#         type             = "forward"
#         target_group_arn = aws_lb_target_group.jlrm_lb_tg.arn
#     }  
# }

# resource "aws_alb_listener" "http" {
#     load_balancer_arn = aws_lb.jlrm_alb.arn
#     port              = 80
#     protocol          = "HTTP"
    
#     default_action {
#         type = "redirect"

#         redirect {
#             port        = "443"
#             protocol    = "HTTPS"
#             status_code = "HTTP_301"
#         }
#     }    
# }