| **English** | [日本語](/modules/secretsmanager/README-ja.md) |
| --- | --- |

## Overview
This module creates a secret in AWS Secrets Manager.

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
| [aws_secretsmanager_secret.app_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.app_secrets_val](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Project name | `string` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment (dev, stg, prod) | `string` | n/a | yes |
| <a name="input_recovery_window_in_days"></a> [recovery\_window\_in\_days](#input\_recovery\_window\_in\_days) | Number of days that Secrets Manager waits before it can delete the secret | `number` | `0` | no |
| <a name="input_secret_values"></a> [secret\_values](#input\_secret\_values) | A JSON-encoded containing the secret key-value pairs | `string` | n/a | yes |
| <a name="input_secrets_name"></a> [secrets\_name](#input\_secrets\_name) | Name of the secret. The final name will be formatted as `<app_name>-<env>-<secrets_name>`. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_secret_arn"></a> [secret\_arn](#output\_secret\_arn) | The ARN of the secret |
<!-- END_TF_DOCS -->