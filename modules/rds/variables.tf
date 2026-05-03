variable "app_name" {
  type = string 
  description = "Project name"
}
variable "env" {
  type = string
  description = "Environment (dev, stg, prod)"
}

variable "vpc_id" {
  type = string
  description = "ID of the VPC"
}

variable "common_tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add to all resources"
}

variable "private_subnet_ids" {
  type = list(string)
  description = "List of private subnet IDs"
}

variable "app_sg_id" {
  type = string
  description = "Security group ID of the application (ECS Fargate service). Used to allow communication from the application to the RDS instance."
}

variable "sg_db_protocol" {
  type    = string
  description = "Communication protocol for the security group"
  default = "tcp"
}

variable "password_length" {
  type    = number
  description = "Number of characters for the password"
  default = 16
}
variable "is_special" {
  type    = bool
  description = "Whether to include special characters (symbols) in the password"
  default = true
}

variable "engine" {
  type = string
  description = "DB engine name (e.g., postgres)"
}
variable "engine_version" {
  type = string
  description = "DB engine version (e.g., 17.6)"
}
variable "instance_class" {
  type = string
  description = "Instance class name (e.g., db.m7g.large)"
}

variable "allocated_storage" {
  type    = number
  description = "Initial storage capacity (GB)"
  default = 20
}
variable "max_allocated_storage" {
  type    = number
  description = "Maximum limit for storage auto-scaling (GB)"
  default = 100
}
variable "storage_type" {
  type    = string
  description = "Storage type"
  default = "gp3"
}
variable "is_skip_final_snapshot" {
  type    = bool
  description = "Whether to skip creating a final DB snapshot before the DB instance is deleted"
  default = false
}
variable "is_deletion_protection" {
  type    = bool
  description = "Whether to enable deletion protection for the DB instance"
  default = true
}

variable "db_name" {
  type = string
  description = "Initial database name"
}
variable "db_username" {
  type      = string
  description = "Initial username"
  default   = "dbadmin"
  sensitive = true
}
variable "db_port" {
  type = number
  description = "Port used for communication with the RDS instance"
}