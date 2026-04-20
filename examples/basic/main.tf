locals {
  common_tags = {
    Environment = var.env
    Project     = var.app_name
  }
}

module "vpc" {
  source = "github.com/dino0320/terraform-aws-ecs-fargate-alb//modules/vpc?ref=v1.0.0"

  region               = var.region
  app_name             = var.app_name
  env                  = var.env
  common_tags          = local.common_tags
  availability_zones   = var.availability_zones
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  app_sg_id            = module.ecs_app.ecs_sg_id

  is_nat_gateway     = true
  interface_services = ["ecr.dkr", "ecr.api", "logs"]
  gateway_services   = ["s3"]
}

module "alb" {
  source = "github.com/dino0320/terraform-aws-ecs-fargate-alb//modules/alb?ref=v1.0.0"

  app_name          = var.app_name
  env               = var.env
  vpc_id            = module.vpc.vpc_id
  common_tags       = local.common_tags
  public_subnet_ids = module.vpc.public_subnet_ids
  app_sg_id         = module.ecs_app.ecs_sg_id
  target_port       = var.web_port
}

module "log_group" {
  source = "github.com/dino0320/terraform-aws-ecs-fargate-alb//modules/cloudwatch?ref=v1.0.0"

  app_name    = var.app_name
  env         = var.env
  common_tags = local.common_tags

  log_group_name = "log-group"
}

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
  endpoint_sg_id     = null
  is_endpoint        = false

  cpu    = "1024" # 1 vCPU
  memory = "3072" # 3 GB

  container_definitions = [
    jsondecode(templatefile("${path.module}/task_definition/web_container_definition.tpl", {
      image_url              = "nginx:latest"
      port                   = var.web_port
      env                    = var.env
      log_group              = module.log_group.log_group_name
      region                 = var.region
    }))
  ]

  task_definition_file_path = "${path.module}/task_definition/task_definition.json"
  desired_count             = 1
  target_group_arn          = module.alb.target_group_arn
  target_container          = "web"
  target_port               = var.web_port
}