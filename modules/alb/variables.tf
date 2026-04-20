variable "app_name" { type = string }
variable "env" { type = string }

variable "vpc_id" { type = string }

variable "common_tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add to all resources"
}

variable "public_subnet_ids" { type = list(string) }

variable "app_sg_id" { type = string }

variable "sg_target_protocol" {
  type    = string
  default = "tcp"
}

variable "target_port" { type = number }
variable "target_protocol" {
  type    = string
  default = "HTTP"
}

variable "health_check_path" {
  type    = string
  default = "/"
}
variable "healthy_threshold" {
  type    = number
  default = 5
}
variable "unhealthy_threshold" {
  type    = number
  default = 5
}
variable "timeout" {
  type    = number
  default = 10
}
variable "interval" {
  type    = number
  default = 30
}
variable "matcher" {
  type    = string
  default = "200"
}
variable "health_check_port" {
  type    = string
  default = "traffic-port"
}
variable "health_check_protocol" {
  type    = string
  default = "HTTP"
}