variable "app_name" { type = string }
variable "env" { type = string }

variable "common_tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add to all resources"
}

variable "image_name" { type = string }

variable "ecr_max_image_count" {
  type    = number
  default = 10
}