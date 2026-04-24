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

## 自前のDockerイメージを使用する場合のインフラ構築手順
自前のDockerイメージを使う場合、`ECR作成 -> DockerイメージのECRリポジトリへのpush -> その他リソースの構築` の順で実行しなければなりません。  
実行手順の例をまとめました。

### 1. AWS SSOログインする
以下のコマンドを実行してAWS SSOログインします。

```bash
$ aws sso login --profile my-profile
```

### 2. ECRのみ構築する
以下のように `target` を設定し、ECRリポジトリのみ構築します。

```bash
$ terraform apply -target=module.ecr_web -var-file="dev.tfvars"
```

### 3. Dockerイメージをpushする
以下のように作成したECRリポジトリに自前のDockerイメージをpushします。

```bash
$ aws ecr get-login-password --region ap-northeast-1 --profile my-profile | docker login --username AWS --password-stdin 123456789012.dkr.ecr.ap-northeast-1.amazonaws.com
$ docker push 123456789012.dkr.ecr.ap-northeast-1.amazonaws.com/my-app-dev-web-repository:latest
```

### 4. その他のリソースを構築する
以下を実行して、その他のリソースを構築します。

```bash
$ terraform apply -var-file="dev.tfvars"
```