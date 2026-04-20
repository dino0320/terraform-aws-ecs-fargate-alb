variable "app_name" { type = string }
variable "env" { type = string }

variable "common_tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add to all resources"
}

variable "log_group_name" { type = string }

variable "log_retention_days" {
  type    = number
  default = 30
}