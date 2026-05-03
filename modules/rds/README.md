| **English** | [日本語](/modules/rds/README-ja.md) |
| --- | --- |

## Overview
This module creates an RDS instance within private subnets.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_secretsmanager_secret.db_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.db_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [random_password.db_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | Initial storage capacity (GB) | `number` | `20` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Project name | `string` | n/a | yes |
| <a name="input_app_sg_id"></a> [app\_sg\_id](#input\_app\_sg\_id) | Security group ID of the application (ECS Fargate service). Used to allow communication from the application to the RDS instance. | `string` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Initial database name | `string` | n/a | yes |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | Port used for communication with the RDS instance | `number` | n/a | yes |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | Initial username | `string` | `"dbadmin"` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | DB engine name (e.g., postgres) | `string` | n/a | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | DB engine version (e.g., 17.6) | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment (dev, stg, prod) | `string` | n/a | yes |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | Instance class name (e.g., db.m7g.large) | `string` | n/a | yes |
| <a name="input_is_deletion_protection"></a> [is\_deletion\_protection](#input\_is\_deletion\_protection) | Whether to enable deletion protection for the DB instance | `bool` | `true` | no |
| <a name="input_is_skip_final_snapshot"></a> [is\_skip\_final\_snapshot](#input\_is\_skip\_final\_snapshot) | Whether to skip creating a final DB snapshot before the DB instance is deleted | `bool` | `false` | no |
| <a name="input_is_special"></a> [is\_special](#input\_is\_special) | Whether to include special characters (symbols) in the password | `bool` | `true` | no |
| <a name="input_max_allocated_storage"></a> [max\_allocated\_storage](#input\_max\_allocated\_storage) | Maximum limit for storage auto-scaling (GB) | `number` | `100` | no |
| <a name="input_password_length"></a> [password\_length](#input\_password\_length) | Number of characters for the password | `number` | `16` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | List of private subnet IDs | `list(string)` | n/a | yes |
| <a name="input_sg_db_protocol"></a> [sg\_db\_protocol](#input\_sg\_db\_protocol) | Communication protocol for the security group | `string` | `"tcp"` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | Storage type | `string` | `"gp3"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_db_instance_address"></a> [db\_instance\_address](#output\_db\_instance\_address) | The hostname of the RDS instance for database connections |
| <a name="output_db_password_secret_arn"></a> [db\_password\_secret\_arn](#output\_db\_password\_secret\_arn) | The ARN of the Secrets Manager secret containing the DB password |
<!-- END_TF_DOCS -->

## Notes
- `skip_final_snapshot` is set to `true` when `env` is `dev`.  
For all other environments, it is set to `false`, ensuring a snapshot is retained when the instance is deleted.
- `deletion_protection` is set to `true` only when `env` is `prod`.  
In the production environment, you must manually disable protection before the instance can be deleted.