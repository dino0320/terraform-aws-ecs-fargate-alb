| **English** | [日本語](/modules/alb/README-ja.md) |
| --- | --- |

## alb
This module creates an Application Load Balancer (ALB) in public subnets to enable internet connectivity for your application.

### Required Variables
| Name | Type | Description |
|---|---|---|
| app_name | string | Project name |
| env | string | Environment (dev, stg, prod) |
| vpc_id | string | ID of the VPC |
| public_subnet_ids | list(string) | List of public subnet IDs |
| app_sg_id | string | Security group ID of the application (ECS Fargate service). Used to allow traffic from the ALB to the application. |
| target_port | number | Port used for communication with the application |

### Optional Variables
| Name | Type | Default | Description |
|---|---|---|---|
| common_tags | map(string) | {} | Map of common tags |
| sg_target_protocol | string | tcp | Communication protocol with the application for the security group |
| target_protocol | string | HTTP | Communication protocol with the application |
| health_check_path | string | / | Destination path for health checks |
| healthy_threshold | number | 5 | Number of consecutive successful health checks required before considering an unhealthy target healthy |
| unhealthy_threshold | number | 5 | Number of consecutive failed health checks required before considering a target unhealthy |
| timeout | number | 10 | Amount of time, in seconds, during which no response means a failed health check |
| interval | number | 30 | Approximate amount of time, in seconds, between health checks of an individual target |
| matcher | string | 200 | HTTP codes to use when checking for a successful response from a target |
| health_check_port | string | traffic-port | Port to use to connect with the target for health checks |
| health_check_protocol | string | HTTP | Protocol to use to connect with the target for health checks |

### Outputs
| Name | Description |
|---|---|
| alb_dns_name | The DNS name of the ALB |
| target_group_arn | The ARN of the Target Group |
| alb_sg_id | The Security Group ID assigned to the ALB |

### Notes
- The HTTP listener is created only when `env` is set to `dev`.  
For environments other than `dev`, communication is restricted to HTTPS listeners only.  
*Note: The definition for the HTTPS listener is currently commented out. To use HTTPS, you must issue a certificate via AWS Certificate Manager (ACM) and adjust the module configuration accordingly.*