| **English** | [日本語](/modules/alb/README-ja.md) |
| --- | --- |

## Overview
This module creates an Application Load Balancer (ALB) in public subnets to enable internet connectivity for your application.

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
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_security_group.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Project name | `string` | n/a | yes |
| <a name="input_app_sg_id"></a> [app\_sg\_id](#input\_app\_sg\_id) | Security group ID of the application (ECS Fargate service). Used to allow traffic from the ALB to the application. | `string` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment (dev, stg, prod) | `string` | n/a | yes |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | Destination path for health checks | `string` | `"/"` | no |
| <a name="input_health_check_port"></a> [health\_check\_port](#input\_health\_check\_port) | Port to use to connect with the target for health checks | `string` | `"traffic-port"` | no |
| <a name="input_health_check_protocol"></a> [health\_check\_protocol](#input\_health\_check\_protocol) | Protocol to use to connect with the target for health checks | `string` | `"HTTP"` | no |
| <a name="input_healthy_threshold"></a> [healthy\_threshold](#input\_healthy\_threshold) | Number of consecutive successful health checks required before considering an unhealthy target healthy | `number` | `5` | no |
| <a name="input_interval"></a> [interval](#input\_interval) | Approximate amount of time, in seconds, between health checks of an individual target | `number` | `30` | no |
| <a name="input_is_http"></a> [is\_http](#input\_is\_http) | Whether to enable HTTP | `bool` | `false` | no |
| <a name="input_matcher"></a> [matcher](#input\_matcher) | HTTP codes to use when checking for a successful response from a target | `string` | `"200"` | no |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | List of public subnet IDs | `list(string)` | n/a | yes |
| <a name="input_sg_target_protocol"></a> [sg\_target\_protocol](#input\_sg\_target\_protocol) | Communication protocol with the application for the security group | `string` | `"tcp"` | no |
| <a name="input_target_port"></a> [target\_port](#input\_target\_port) | Port used for communication with the application | `number` | n/a | yes |
| <a name="input_target_protocol"></a> [target\_protocol](#input\_target\_protocol) | Communication protocol with the application | `string` | `"HTTP"` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Amount of time, in seconds, during which no response means a failed health check | `number` | `10` | no |
| <a name="input_unhealthy_threshold"></a> [unhealthy\_threshold](#input\_unhealthy\_threshold) | Number of consecutive failed health checks required before considering a target unhealthy | `number` | `5` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | The DNS name of the load balancer |
| <a name="output_alb_sg_id"></a> [alb\_sg\_id](#output\_alb\_sg\_id) | The Security Group ID assigned to the ALB |
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | The ARN of the Target Group |
<!-- END_TF_DOCS -->

## Notes
- The HTTP listener is created only when `env` is set to `dev`.  
For environments other than `dev`, communication is restricted to HTTPS listeners only.  
*Note: The definition for the HTTPS listener is currently commented out. To use HTTPS, you must issue a certificate via AWS Certificate Manager (ACM) and adjust the module configuration accordingly.*