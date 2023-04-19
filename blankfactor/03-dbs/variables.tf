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

variable "jlrm_sg_ec2" {

}

variable "rds_instance_class"{
    type = string
} 

variable "rds_allocated_storage"{
    type = number
} 
variable "rds_username"{
    type = string
} 


variable prefix_resources_name {
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