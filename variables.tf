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

variable "other_tags" {
  type        = map(string)
  default     = {}
  description = "Tags the user wants add"
}

