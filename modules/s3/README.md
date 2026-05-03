| **English** | [日本語](/modules/s3/README-ja.md) |
| --- | --- |

## Overview
This module creates an S3 bucket.

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
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | AWS Account ID | `string` | n/a | yes |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Project name | `string` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment (dev, stg, prod) | `string` | n/a | yes |
| <a name="input_is_private_access"></a> [is\_private\_access](#input\_is\_private\_access) | Whether to restrict access to private | `string` | `true` | no |
| <a name="input_is_versioning"></a> [is\_versioning](#input\_is\_versioning) | Whether to enable versioning for the bucket | `string` | `false` | no |
| <a name="input_storage_name"></a> [storage\_name](#input\_storage\_name) | Storage name. The bucket name will be formatted as `<account_id>-<app_name>-<env>-<storage_name>`. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->