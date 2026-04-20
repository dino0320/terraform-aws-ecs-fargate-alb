variable "account_id" { type = string }

variable "app_name" { type = string }
variable "env" { type = string }

variable "common_tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add to all resources"
}

variable "storage_name" { type = string }

variable "is_private_access" {
  type    = string
  default = true
}

variable "is_versioning" {
  type    = string
  default = false
}