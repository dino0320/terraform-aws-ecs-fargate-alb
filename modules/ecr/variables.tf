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

variable "image_name" {
  type = string
  description = "Name of the Docker image to be managed in the repository"
}

variable "ecr_max_image_count" {
  type    = number
  description = "Maximum number of images to retain in the repository (older images are deleted automatically)"
  default = 10
}