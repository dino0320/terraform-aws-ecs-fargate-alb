| **English** | [日本語](/modules/cloudwatch/README-ja.md) |
| --- | --- |

## Overview
This module creates a CloudWatch Logs log group.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Project name | `string` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment (dev, stg, prod) | `string` | n/a | yes |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | Name of the log group. The final name will be formatted as `<app_name>-<env>-<log_group_name>`. | `string` | n/a | yes |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | Log retention period in days | `number` | `30` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_log_group_name"></a> [log\_group\_name](#output\_log\_group\_name) | The full name of the log group (including the project name and environment) |
<!-- END_TF_DOCS -->