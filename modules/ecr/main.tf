resource "aws_ecr_repository" "this" {
  name                 = "${var.app_name}-${var.env}-${var.image_name}-repository"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(var.common_tags, {
    Name = "${var.app_name}-${var.env}-${var.image_name}-repository"
  })
}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep the specific number of images"
      selection = {
        tagStatus   = "any"
        countType = "sinceImagePushed"
        countUnit = "days"
        countNumber = var.ecr_max_image_count
      }
      action = {
        type = "expire"
      }
    }]
  })
}