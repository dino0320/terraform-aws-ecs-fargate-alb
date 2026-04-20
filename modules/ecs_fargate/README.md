| **English** | [日本語](/modules/ecs_fargate/README-ja.md) |
| --- | --- |

## ecs_fargate
This module creates an ECS Fargate service (application) within private subnets, connected to the internet via an Application Load Balancer (ALB).

### Required Variables
| Name | Type | Description |
|---|---|---|
| account_id | string | AWS Account ID |
| region | string | AWS Region (e.g., ap-northeast-1) |
| app_name | string | Project name |
| env | string | Environment (loc, dev, stg, prod) |
| vpc_id | string | ID of the VPC |
| private_subnet_ids | list(string) | List of private subnet IDs |
| alb_sg_id | string | Security Group ID assigned to the ALB. Used to allow communication from the ALB to ECS. |
| endpoint_sg_id | string | Security Group ID assigned to the VPC Endpoints. Used to allow communication from ECS to VPC Endpoints. Specify `null` if `is_endpoint` is set to `false`. |
| container_definitions | list(any) | List of container definitions for the ECS task |
| task_definition_file_path | string | Path to output the task definition JSON file. Intended for use in CI/CD pipelines like GitHub Actions. |
| target_group_arn | string | ARN of the Target Group |
| target_container | string | Name of the container to be associated with the target group |
| target_port | number | Port used for communication with the target container |

### Optional Variables
| Name | Type | Default | Description |
|---|---|---|---|
| common_tags | map(string) | {} | Map of common tags |
| sg_target_protocol | string | tcp | Communication protocol for the security group (ALB to ECS) |
| is_endpoint | bool | true | Whether to enable communication with VPC Endpoints |
| is_cloud_watch_logs | bool | true | Whether to create a CloudWatch Logs log group |
| is_secrets_manager | bool | true | Whether to allow retrieving secrets from Secrets Manager |
| custom_task_role_policy | string | null | JSON-encoded policy to attach to the ECS Task Role (e.g., for S3 access) |
| cpu | string | 1024 | CPU units to allocate to the task (1024 = 1vCPU) |
| memory | string | 3072 | Amount of memory (MiB) to allocate to the task |
| desired_count | number | 1 | Number of tasks to run concurrently |

### Outputs
| Name | Description |
|---|---|
| ecs_sg_id | The Security Group ID assigned to the ECS service |