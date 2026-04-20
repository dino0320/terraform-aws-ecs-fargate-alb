variable "account_id" { type = string }
variable "region" { type = string }

variable "app_name" { type = string }
variable "env" { type = string }

variable "vpc_id" { type = string }

variable "common_tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add to all resources"
}

variable "private_subnet_ids" { type = list(string) }

variable "alb_sg_id" { type = string }
variable "endpoint_sg_id" {
  type    = string
  default = null
}

variable "sg_target_protocol" {
  type    = string
  default = "tcp"
}

variable "is_endpoint" {
  type    = bool
  default = true
}

variable "is_cloud_watch_logs" {
  type    = bool
  default = true
}
variable "is_secrets_manager" {
  type    = bool
  default = true
}
variable "custom_task_role_policy" {
  type        = string
  default     = null
  description = "A JSON-encoded IAM policy for app-specific permissions (e.g., S3 access), applied only if provided"
}

variable "cpu" {
  type    = string
  default = "1024"
}
variable "memory" {
  type    = string
  default = "3072"
}

variable "container_definitions" {
  type        = list(any)
  description = "A list of container definitions for the ECS task"
}
variable "task_definition_file_path" { type = string }

variable "desired_count" {
  type    = number
  default = 1
}

variable "target_group_arn" { type = string }
variable "target_container" { type = string }
variable "target_port" { type = number }