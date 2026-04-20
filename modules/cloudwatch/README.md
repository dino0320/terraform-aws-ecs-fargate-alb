| **English** | [日本語](/modules/cloudwatch/README-ja.md) |
| --- | --- |

## cloudwatch
This module creates a CloudWatch Logs log group.

### Required Variables
| Name | Type | Description |
|---|---|---|
| app_name | string | Project name |
| env | string | Environment (loc, dev, stg, prod) |
| log_group_name | string | Name of the log group. The final name will be formatted as `<app_name>-<env>-<log_group_name>`. |

### Optional Variables
| Name | Type | Default | Description |
|---|---|---|---|
| common_tags | map(string) | {} | Map of common tags |
| log_retention_days | number | 30 | Log retention period in days |

### Outputs
| Name | Description |
|---|---|
| log_group_name | The full name of the log group (including the project name and environment) |