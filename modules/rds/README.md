| **English** | [日本語](/modules/rds/README-ja.md) |
| --- | --- |

## rds
This module creates an RDS instance within private subnets.

### Required Variables
| Name | Type | Description |
|---|---|---|
| app_name | string | Project name |
| env | string | Environment (dev, stg, prod) |
| vpc_id | string | ID of the VPC |
| private_subnet_ids | list(string) | List of private subnet IDs |
| app_sg_id | string | Security group ID of the application (ECS Fargate service). Used to allow communication from the application to the RDS instance. |
| engine | string | DB engine name (e.g., postgres) |
| engine_version | string | DB engine version (e.g., 17.6) |
| instance_class | string | Instance class name (e.g., db.m7g.large) |
| db_name | string | Initial database name |
| db_port | number | Port used for communication with the RDS instance |

### Optional Variables
| Name | Type | Default | Description |
|---|---|---|---|
| common_tags | map(string) | {} | Map of common tags |
| sg_db_protocol | string | tcp | Communication protocol for the security group |
| password_length | number | 16 | Number of characters for the password |
| is_special | bool | true | Whether to include special characters (symbols) in the password |
| allocated_storage | number | 20 | Initial storage capacity (GB) |
| max_allocated_storage | number | 100 | Maximum limit for storage auto-scaling (GB) |
| storage_type | string | gp3 | Storage type |
| db_username | string | dbadmin | Initial username |

### Outputs
| Name | Description |
|---|---|
| db_instance_address | The hostname of the RDS instance |
| db_password_secret_arn | The ARN of the Secrets Manager secret storing the DB password |

### Notes
- `skip_final_snapshot` is set to `true` when `env` is `dev`.  
For all other environments, it is set to `false`, ensuring a snapshot is retained when the instance is deleted.
- `deletion_protection` is set to `true` only when `env` is `prod`.  
In the production environment, you must manually disable protection before the instance can be deleted.