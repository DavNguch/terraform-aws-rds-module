variable "db_instance_class" {
    description = "Instance class for my database"
    type = string
}

variable "private_data_subnet_ids" {
    description = "private_data_subnet ids"
    type = list(string)
}

variable "aws_region" {
    description = "my aws region"
    type = string
}

variable "resource_tags" {
    description = "value"
    type = map(string)
}

variable "db_username" {
    description = "Database username"
    type = string
}

variable "db_password" {
    description = "Database admin password"
    type = string
    sensitive = true
}

variable "db_engine" {
    description = "type of databse engine"
    type = string
}

variable "db_engine_version" {
    description = "the database engine version"
    type = string
}

variable "db_storage_type" {
    description = "type of storage for my database"
    type = string
}

variable "db_allocated_storage" {
    description = "allocated storage for my database"
    type = number
}

variable "skip_final_snapshot" {
    description = "skip_final_snapshot of my database"
    type = bool 
}

variable "multi_az" {
    description = "Enable Multi-AZ deployment for my database"
    type = bool
}

variable "vpc_id" {
    description = "VPC ID"
    type = string
}

variable "private_application_subnet_cidrs" {
    description = "private_application_cidr"
    type = list(string)
}