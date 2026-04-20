variable "app_name" { type = string }
variable "env" { type = string }

variable "common_tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add to all resources"
}

variable "secrets_name" { type = string }

variable "recovery_window_in_days" {
  type    = number
  default = 0
}

variable "secret_values" {
  type        = string
  description = "A JSON-encoded containing the secret key-value pairs"
}