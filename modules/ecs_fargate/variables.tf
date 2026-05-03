variable "account_id" {
  type = string
  description = "AWS Account ID"
}
variable "region" {
  type = string
  description = "AWS Region (e.g., ap-northeast-1)"
}

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

variable "alb_sg_id" {
  type = string
  description = "Security Group ID assigned to the ALB. Used to allow communication from the ALB to ECS."
}
variable "endpoint_sg_id" {
  type    = string
  description = "Security Group ID assigned to the VPC Endpoints. Used to allow communication from ECS to VPC Endpoints. Specify `null` if `is_endpoint` is set to `false`."
  default = null
}

variable "sg_target_protocol" {
  type    = string
  description = "Communication protocol for the security group (ALB to ECS)"
  default = "tcp"
}

variable "is_endpoint" {
  type    = bool
  description = "Whether to enable communication with VPC Endpoints"
  default = true
}

variable "is_cloud_watch_logs" {
  type    = bool
  description = "Whether to create a CloudWatch Logs log group"
  default = true
}
variable "is_secrets_manager" {
  type    = bool
  description = "Whether to allow retrieving secrets from Secrets Manager"
  default = true
}
variable "custom_task_role_policy" {
  type        = string
  default     = null
  description = "A JSON-encoded IAM policy for app-specific permissions (e.g., S3 access), applied only if provided"
}

variable "cpu" {
  type    = string
  description = "CPU units to allocate to the task (1024 = 1vCPU)"
  default = "1024"
}
variable "memory" {
  type    = string
  description = "Amount of memory (MiB) to allocate to the task"
  default = "3072"
}

variable "container_definitions" {
  type        = list(any)
  description = "A list of container definitions for the ECS task"
}
variable "task_definition_file_path" {
  type = string
  description = "Path to output the task definition JSON file. Intended for use in CI/CD pipelines like GitHub Actions."
}

variable "desired_count" {
  type    = number
  description = "Number of tasks to run concurrently"
  default = 1
}

variable "target_group_arn" {
  type = string
  description = "ARN of the Target Group"
}
variable "target_container" {
  type = string
  description = "Name of the container to be associated with the target group"
}
variable "target_port" {
  type = number
  description = "Port used for communication with the target container"
}