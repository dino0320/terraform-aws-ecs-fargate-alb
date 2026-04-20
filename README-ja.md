| **日本語** | [English](/README.md) |
| --- | --- |

## 概要
AWSのECS Fargate + ALB構成のプロジェクトを作成するためのTerraformモジュールです。

## サンプルアーキテクチャ図
![サンプルアーキテクチャ図](/images/architecture_diagram_sample.png "サンプルアーキテクチャ図")

## 環境
- Terraform 1.14+
- hashicorp/aws 6.40.0 (AWSプロバイダ)

## サンプル
- [Basic NGINX構成例](/examples/basic/README-ja.md): NGINXを用いた基本的なアーキテクチャ例です。

## 利用例
```tf
# 共通タグ
locals {
  common_tags = {
    Environment = var.env
    Project     = var.app_name
  }
}

# ネットワーク定義
module "vpc" {
  source = "github.com/dino0320/terraform-aws-ecs-fargate-alb//modules/vpc?ref=v1.0.0"

  region               = var.region
  app_name             = var.app_name
  env                  = var.env
  common_tags          = local.common_tags
  ...
}

# アプリケーションロードバランサー定義
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

# ECS Fargateアプリケーション定義
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

# データベースやCloudWatch Logs、SecretsManager等を定義
...
```

## 各コンポーネントの解説
- [alb](/modules/alb/README-ja.md)
- [cloudwatch](/modules/cloudwatch/README-ja.md)
- [ecr](/modules/ecr/README-ja.md)
- [ecs_fargate](/modules/ecs_fargate/README-ja.md)
- [rds](/modules/rds/README-ja.md)
- [s3](/modules/s3/README-ja.md)
- [secretsmanager](/modules/secretsmanager/README-ja.md)
- [vpc](/modules/vpc/README-ja.md)