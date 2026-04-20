| **English** | [日本語](/modules/secretsmanager/README-ja.md) |
| --- | --- |

## secretsmanager
This module creates a secret in AWS Secrets Manager.

### Required Variables
| Name | Type | Description |
|---|---|---|
| app_name | string | Project name |
| env | string | Environment (loc, dev, stg, prod) |
| secrets_name | string | Name of the secret. The final name will be formatted as `<app_name>-<env>-<secrets_name>`. |
| secret_values | string | JSON-encoded key-value pairs for the secret |

### Optional Variables
| Name | Type | Default | Description |
|---|---|---|---|
| common_tags | map(string) | {} | Map of common tags |
| recovery_window_in_days | number | 0 | Number of days that Secrets Manager waits before it can delete the secret |

### Outputs
| Name | Description |
|---|---|
| secret_arn | The ARN of the secret |