resource "aws_s3_bucket" "this" {
  bucket = "${var.account_id}-${var.app_name}-${var.env}-${var.storage_name}"

  tags = merge(var.common_tags, {
    Name = "${var.account_id}-${var.app_name}-${var.env}-${var.storage_name}"
  })
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.is_private_access
  block_public_policy     = var.is_private_access
  ignore_public_acls      = var.is_private_access
  restrict_public_buckets = var.is_private_access
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.is_versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}