variable "account_id" { type = string }
variable "region" { type = string }
variable "profile" { type = string }

variable "app_name" { type = string }
variable "env" { type = string }

variable "availability_zones" { type = list(string) }

variable "vpc_cidr" { type = string }

variable "public_subnet_cidrs" { type = list(string) }
variable "private_subnet_cidrs" { type = list(string) }

variable "web_port" { type = number }