terraform {
    required_version = ">= 1.4.5"

    required_providers {
        aws = {
        version = "=4.63.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}