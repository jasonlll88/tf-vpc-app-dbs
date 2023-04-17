terraform {
    required_version = ">= 1.4.5"

    required_providers {
        aws = {
        version = "=4.63.0"
        }
    }

    backend "s3" {
        bucket          = "terraform-state-interview-31"
        key             = "state/interview-31"
        region          = "us-east-1"
        encrypt        	= true
        dynamodb_table  = "terraform-interview-31"
    }    
    # backend "s3" {
    #     bucket          = "terraform-state-"
    #     key             = "state/interview-31"
    #     region          = "us-east-1"
    #     encrypt        	= true
    #     dynamodb_table  = "terraform-state-lock"
    # }    
}

provider "aws" {
    region = "us-east-1"
}