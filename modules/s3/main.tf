resource "aws_s3_bucket" "static_assets" {
  bucket = "app-static-assets"
  acl    = "public-read"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "expire_old_versions"
    enabled = true

    noncurrent_version_expiration {
      days = 30
    }
  }

  tags = {
    Name = "static-assets-bucket"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.static_assets.id
}
