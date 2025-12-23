variable "region" {
    description = "The AWS region to deploy resources in."
    type        = string
}

variable "vpc_cidr_block" {
    description = "The CIDR block for the VPC."
    type        = string
}

variable "rds_snapshot_identifier" {
    description = "The identifier for the RDS snapshot."
    type        = string
}