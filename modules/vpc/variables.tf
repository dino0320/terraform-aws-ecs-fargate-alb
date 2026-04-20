variable "region" { type = string }

variable "app_name" { type = string }
variable "env" { type = string }

variable "common_tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add to all resources"
}

variable "availability_zones" { type = list(string) }

variable "vpc_cidr" { type = string }

variable "public_subnet_cidrs" { type = list(string) }
variable "private_subnet_cidrs" { type = list(string) }

variable "app_sg_id" { type = string }

variable "is_nat_gateway" { type = bool }

variable "interface_services" {
  type    = list(string)
  default = []
}
variable "gateway_services" {
  type    = list(string)
  default = []
}