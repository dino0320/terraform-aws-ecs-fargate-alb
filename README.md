| [日本語](/README-ja.md) | **English** |
| --- | --- |

## Overview
These are Terraform modules for an architecture using AWS ECS Fargate + ALB.

## Sample Architecture Diagram
![Sample architecture diagram](/images/architecture_diagram_sample.png "Sample architecture diagram")

## Environment
- Terraform 1.14+
- hashicorp/aws 6.40.0 (AWS provider)

## Examples
- [Basic NGINX App](/examples/basic/README.md): A basic example.

## Useage
```tf
# Common tags
locals {
  common_tags = {
    Environment = var.env
    Project     = var.app_name
  }
}

# Network
module "vpc" {
  source = "github.com/dino0320/terraform-aws-ecs-fargate-alb//modules/vpc?ref=v1.0.0"

  region               = var.region
  app_name             = var.app_name
  env                  = var.env
  common_tags          = local.common_tags
  ...
}

# Application Load Balancer (ALB)
module "alb" {
  source = "github.com/dino0320/terraform-aws-ecs-fargate-alb//modules/alb?ref=v1.0.0"

  app_name          = var.app_name
  env               = var.env
  vpc_id            = module.vpc.vpc_id
  common_tags       = local.common_tags
  public_subnet_ids = module.vpc.public_subnet_ids
  app_sg_id         = module.ecs_app.ecs_sg_id
  target_port       = var.frontend_port
}

# ECS Fargate
module "ecs_app" {
  source = "github.com/dino0320/terraform-aws-ecs-fargate-alb//modules/ecs_fargate?ref=v1.0.0"

  account_id         = var.account_id
  region             = var.region
  app_name           = var.app_name
  env                = var.env
  vpc_id             = module.vpc.vpc_id
  common_tags        = local.common_tags
  private_subnet_ids = module.vpc.private_subnet_ids
  alb_sg_id          = module.alb.alb_sg_id
  endpoint_sg_id     = module.vpc.endpoint_sg_id
  ...
}

# Database, CloudWatch Logs, SecretsManager, and etc.
...
```

## Documents of Components
- [alb](/modules/alb/README.md)
- [cloudwatch](/modules/cloudwatch/README.md)
- [ecr](/modules/ecr/README.md)
- [ecs_fargate](/modules/ecs_fargate/README.md)
- [rds](/modules/rds/README.md)
- [s3](/modules/s3/README.md)
- [secretsmanager](/modules/secretsmanager/README.md)
- [vpc](/modules/vpc/README.md)

## Infrastructure Deployment Steps for Custom Docker Images
When using custom Docker images, resources must be deployed in the following order: `Create ECR -> Push Docker Image to ECR -> Deploy remaining resources`.  
Below is an example of the execution procedure.

### 1. AWS SSO Login
Execute the following command to authenticate via AWS SSO:

```bash
$ aws sso login --profile my-profile
```

### 2. Deploy ECR Resources Only
Use the `-target` flag to deploy only the ECR repositories first.

```bash
$ terraform apply -target=module.ecr_web -var-file="dev.tfvars"
```

### 3. Push Docker Images
Push your custom Docker images to the newly created ECR repositories.

```bash
$ aws ecr get-login-password --region ap-northeast-1 --profile my-profile | docker login --username AWS --password-stdin 123456789012.dkr.ecr.ap-northeast-1.amazonaws.com
$ docker push 123456789012.dkr.ecr.ap-northeast-1.amazonaws.com/my-app-dev-web-repository:latest
```

### 4. Deploy Remaining Resources
Finally, execute a full apply to build the rest of the infrastructure.

```bash
$ terraform apply -var-file="dev.tfvars"
```