output "jlrm_sg_ec2" {
    value = aws_security_group.instance_sg
}
output "jlrm_alb" {
    value = aws_lb.jlrm_alb
}