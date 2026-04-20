| **English** | [日本語](/modules/ecr/README-ja.md) |
| --- | --- |

## ecr
This module creates an ECR (Elastic Container Registry) private repository.

### Required Variables
| Variable Name | Type | Description |
|---|---|---|
| app_name | string | Project name |
| env | string | Environment (dev, stg, prod) |
| image_name | string | Name of the Docker image to be managed in the repository |

### Optional Variables
| Variable Name | Type | Default | Description |
|---|---|---|---|
| common_tags | map(string) | {} | Map of common tags |
| ecr_max_image_count | number | 10 | Maximum number of images to retain in the repository (older images are deleted automatically) |

### Outputs
| Variable Name | Description |
|---|---|
| repository_url | The URL of the repository |