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

variable "public_subnet_ids" {
  type = list(string)
  description = "List of public subnet IDs"
}

variable "app_sg_id" {
  type = string
  description = "Security group ID of the application (ECS Fargate service). Used to allow traffic from the ALB to the application."
}

variable "sg_target_protocol" {
  type    = string
  description = "Communication protocol with the application for the security group"
  default = "tcp"
}

variable "target_port" {
  type = number
  description = "Port used for communication with the application"
}
variable "target_protocol" {
  type    = string
  description = "Communication protocol with the application"
  default = "HTTP"
}

variable "is_http" {
  type    = bool
  description = "Whether to enable HTTP"
  default = false
}

variable "health_check_path" {
  type    = string
  description = "Destination path for health checks"
  default = "/"
}
variable "healthy_threshold" {
  type    = number
  description = "Number of consecutive successful health checks required before considering an unhealthy target healthy"
  default = 5
}
variable "unhealthy_threshold" {
  type    = number
  description = "Number of consecutive failed health checks required before considering a target unhealthy"
  default = 5
}
variable "timeout" {
  type    = number
  description = "Amount of time, in seconds, during which no response means a failed health check"
  default = 10
}
variable "interval" {
  type    = number
  description = "Approximate amount of time, in seconds, between health checks of an individual target"
  default = 30
}
variable "matcher" {
  type    = string
  description = "HTTP codes to use when checking for a successful response from a target"
  default = "200"
}
variable "health_check_port" {
  type    = string
  description = "Port to use to connect with the target for health checks"
  default = "traffic-port"
}
variable "health_check_protocol" {
  type    = string
  description = "Protocol to use to connect with the target for health checks"
  default = "HTTP"
}