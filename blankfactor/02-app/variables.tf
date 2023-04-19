variable "vpc_id" {
    type = string
}

variable "subnets" {
    type = map
}

variable "public_subnets" {

}

variable "private_subnets" {

}

variable prefix_resources_name {
    type = string
}
variable asg_target_value {
    type = number
}

variable image_ami_id {
    type = string
}
variable ec2_instance_type {
    type = string
}

variable "other_tags" {
    type        = map(string)
    default     = {}
    description = "Tags the user wants add"
}