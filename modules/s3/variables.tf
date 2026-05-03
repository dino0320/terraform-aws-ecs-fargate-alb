variable "account_id" {
  type = string
  description = "AWS Account ID"
}

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

variable "storage_name" {
  type = string
  description = "Storage name. The bucket name will be formatted as `<account_id>-<app_name>-<env>-<storage_name>`."
}

variable "is_private_access" {
  type    = string
  description = "Whether to restrict access to private"
  default = true
}

variable "is_versioning" {
  type    = string
  description = "Whether to enable versioning for the bucket"
  default = false
}