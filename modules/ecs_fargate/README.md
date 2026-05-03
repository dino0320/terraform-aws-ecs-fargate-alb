| **English** | [日本語](/modules/ecs_fargate/README-ja.md) |
| --- | --- |

## Overview
This module creates an ECS Fargate service (application) within private subnets, connected to the internet via an Application Load Balancer (ALB).

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.cloud_watch_logs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.custom_task_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.secrets_manager_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.execution_role_standard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [local_file.task_definition](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | AWS Account ID | `string` | n/a | yes |
| <a name="input_alb_sg_id"></a> [alb\_sg\_id](#input\_alb\_sg\_id) | Security Group ID assigned to the ALB. Used to allow communication from the ALB to ECS. | `string` | n/a | yes |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Project name | `string` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_container_definitions"></a> [container\_definitions](#input\_container\_definitions) | A list of container definitions for the ECS task | `list(any)` | n/a | yes |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | CPU units to allocate to the task (1024 = 1vCPU) | `string` | `"1024"` | no |
| <a name="input_custom_task_role_policy"></a> [custom\_task\_role\_policy](#input\_custom\_task\_role\_policy) | A JSON-encoded IAM policy for app-specific permissions (e.g., S3 access), applied only if provided | `string` | `null` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | Number of tasks to run concurrently | `number` | `1` | no |
| <a name="input_endpoint_sg_id"></a> [endpoint\_sg\_id](#input\_endpoint\_sg\_id) | Security Group ID assigned to the VPC Endpoints. Used to allow communication from ECS to VPC Endpoints. Specify `null` if `is_endpoint` is set to `false`. | `string` | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment (dev, stg, prod) | `string` | n/a | yes |
| <a name="input_is_cloud_watch_logs"></a> [is\_cloud\_watch\_logs](#input\_is\_cloud\_watch\_logs) | Whether to create a CloudWatch Logs log group | `bool` | `true` | no |
| <a name="input_is_endpoint"></a> [is\_endpoint](#input\_is\_endpoint) | Whether to enable communication with VPC Endpoints | `bool` | `true` | no |
| <a name="input_is_secrets_manager"></a> [is\_secrets\_manager](#input\_is\_secrets\_manager) | Whether to allow retrieving secrets from Secrets Manager | `bool` | `true` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Amount of memory (MiB) to allocate to the task | `string` | `"3072"` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | List of private subnet IDs | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region (e.g., ap-northeast-1) | `string` | n/a | yes |
| <a name="input_sg_target_protocol"></a> [sg\_target\_protocol](#input\_sg\_target\_protocol) | Communication protocol for the security group (ALB to ECS) | `string` | `"tcp"` | no |
| <a name="input_target_container"></a> [target\_container](#input\_target\_container) | Name of the container to be associated with the target group | `string` | n/a | yes |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | ARN of the Target Group | `string` | n/a | yes |
| <a name="input_target_port"></a> [target\_port](#input\_target\_port) | Port used for communication with the target container | `number` | n/a | yes |
| <a name="input_task_definition_file_path"></a> [task\_definition\_file\_path](#input\_task\_definition\_file\_path) | Path to output the task definition JSON file. Intended for use in CI/CD pipelines like GitHub Actions. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_ecs_sg_id"></a> [ecs\_sg\_id](#output\_ecs\_sg\_id) | The Security Group ID assigned to the ECS service |
<!-- END_TF_DOCS -->