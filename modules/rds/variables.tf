variable "app_name" { type = string }
variable "env" { type = string }

variable "vpc_id" { type = string }

variable "common_tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add to all resources"
}

variable "private_subnet_ids" { type = list(string) }

variable "app_sg_id" { type = string }

variable "sg_db_protocol" {
  type    = string
  default = "tcp"
}

variable "password_length" {
  type    = number
  default = 16
}
variable "is_special" {
  type    = bool
  default = true
}

variable "engine" { type = string }
variable "engine_version" { type = string }
variable "instance_class" { type = string }

variable "allocated_storage" {
  type    = number
  default = 20
}
variable "max_allocated_storage" {
  type    = number
  default = 100
}
variable "storage_type" {
  type    = string
  default = "gp3"
}

variable "db_name" { type = string }
variable "db_username" {
  type      = string
  default   = "dbadmin"
  sensitive = true
}
variable "db_port" { type = number }