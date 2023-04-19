variable vpc_cidr_block {
    type = string
}

variable vpc_name {
    type = string
}

variable prefix_resources_name {
    type = string
}

variable subnet_cicd_az_name {
    type = map
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

variable rds_instance_class {
    type = string
} 
variable rds_allocated_storage {
    type = number
}
variable rds_username {
    type = string
} 
variable rds_db_name {
    type = string
}

variable rds_public_access {
    type = bool
} 
variable rds_skip_final_snapshot {
    type = bool
} 
variable "other_tags" {
  type        = map(string)
  default     = {}
  description = "Tags the user wants add"
}

