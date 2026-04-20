| **English** | [日本語](/modules/s3/README-ja.md) |
| --- | --- |

## s3
This module creates an S3 bucket.

### Required Variables
| Name | Type | Description |
|---|---|---|
| account_id | string | AWS Account ID |
| app_name | string | Project name |
| env | string | Environment (loc, dev, stg, prod) |
| storage_name | string | Storage name. The bucket name will be formatted as `<account_id>-<app_name>-<env>-<storage_name>`. |

### Optional Variables
| Name | Type | Default | Description |
|---|---|---|---|
| common_tags | map(string) | {} | Map of common tags |
| is_private_access | bool | true | Whether to restrict access to private |
| is_versioning | bool | false | Whether to enable versioning for the bucket |