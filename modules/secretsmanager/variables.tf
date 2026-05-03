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

variable "secrets_name" {
  type = string
  description = "Name of the secret. The final name will be formatted as `<app_name>-<env>-<secrets_name>`."
}

variable "recovery_window_in_days" {
  type    = number
  description = "Number of days that Secrets Manager waits before it can delete the secret"
  default = 0
}

variable "secret_values" {
  type        = string
  description = "A JSON-encoded containing the secret key-value pairs"
  sensitive   = true
}