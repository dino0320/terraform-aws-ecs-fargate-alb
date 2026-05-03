variable "region" {
  type = string
  description = "AWS Region (e.g., ap-northeast-1)"
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

variable "availability_zones" {
  type = list(string)
  description = "List of Availability Zones (e.g., [\"ap-northeast-1a\", \"ap-northeast-1c\", \"ap-northeast-1d\"])"
}

variable "vpc_cidr" {
  type = string
  description = "CIDR block for the VPC (e.g., 172.32.0.0/16)"
}

variable "public_subnet_cidrs" {
  type = list(string)
  description = "List of CIDR blocks for public subnets (e.g., [\"172.32.0.0/20\", \"172.32.16.0/20\", \"172.32.32.0/20\"])"
}
variable "private_subnet_cidrs" {
  type = list(string)
  description = "List of CIDR blocks for private subnets (e.g., [\"172.32.48.0/20\", \"172.32.64.0/20\", \"172.32.80.0/20\"])"
}

variable "app_sg_id" {
  type = string
  description = "Security group ID of the application (ECS Fargate service). Used to allow communication from the application to VPC endpoints."
}

variable "is_nat_gateway" {
  type = bool
  description = "Whether to create a NAT Gateway"
}

variable "interface_services" {
  type    = list(string)
  description = "List of service names for Interface VPC endpoints (e.g., [\"ecr.dkr\", \"ecr.api\", \"logs\", \"secretsmanager\"])"
  default = []
}
variable "gateway_services" {
  type    = list(string)
  description = "List of service names for Gateway VPC endpoints (e.g., [\"s3\"])"
  default = []
}