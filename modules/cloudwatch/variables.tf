variable "app_name" {
  type = string 
  description = "Project name"
}
variable "env" {
  type = string
  description = "Environment (dev, stg, prod)"
}

variable "common_tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add to all resources"
}

variable "log_group_name" {
  type = string
  description = "Name of the log group. The final name will be formatted as `<app_name>-<env>-<log_group_name>`."
}

variable "log_retention_days" {
  type    = number
  description = "Log retention period in days"
  default = 30
}