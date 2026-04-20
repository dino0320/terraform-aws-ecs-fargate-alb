| **English** | [日本語](/modules/vpc/README-ja.md) |
| --- | --- |

## vpc
This module creates networking resources including VPC, subnets, VPC endpoints, and NAT Gateway.

### Required Variables
| Name | Type | Description |
|---|---|---|
| region | string | AWS Region (e.g., ap-northeast-1) |
| app_name | string | Project name |
| env | string | Environment (dev, stg, prod) |
| availability_zones | list(string) | List of Availability Zones (e.g., ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]) |
| vpc_cidr | string | CIDR block for the VPC (e.g., 172.32.0.0/16) |
| public_subnet_cidrs | list(string) | List of CIDR blocks for public subnets (e.g., ["172.32.0.0/20", "172.32.16.0/20", "172.32.32.0/20"]) |
| private_subnet_cidrs | list(string) | List of CIDR blocks for private subnets (e.g., ["172.32.48.0/20", "172.32.64.0/20", "172.32.80.0/20"]) |
| app_sg_id | string | Security group ID of the application (ECS Fargate service). Used to allow communication from the application to VPC endpoints. |
| is_nat_gateway | bool | Whether to create a NAT Gateway |

### Optional Variables
| Name | Type | Default | Description |
|---|---|---|---|
| common_tags | map(string) | {} | Map of common tags |
| interface_services | list(string) | [] | List of service names for Interface VPC endpoints (e.g., ["ecr.dkr", "ecr.api", "logs", "secretsmanager"]) |
| gateway_services | list(string) | [] | List of service names for Gateway VPC endpoints (e.g., ["s3"]) |

### Outputs
| Name | Description |
|---|---|
| vpc_id | The ID of the VPC |
| public_subnet_ids | List of public subnet IDs |
| private_subnet_ids | List of private subnet IDs |
| endpoint_sg_id | The Security Group ID assigned to the VPC endpoints |