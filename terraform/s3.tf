resource "aws_s3_bucket" "frontend_bucket" {
  bucket = "mern-frontend-joud-2025-v2"
  tags = { Name = "Frontend Hosting" }
}

resource "aws_s3_bucket_website_configuration" "frontend_website" {
  bucket = aws_s3_bucket.frontend_bucket.id
  index_document { suffix = "index.html" }
  error_document { key = "index.html" }
}

resource "aws_s3_bucket_policy" "frontend_policy" {
  bucket = aws_s3_bucket.frontend_bucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Sid       = "PublicReadGetObject",
      Effect    = "Allow",
      Principal = "*",
      Action    = "s3:GetObject",
      Resource  = "${aws_s3_bucket.frontend_bucket.arn}/*"
    }]
  })
}

resource "aws_s3_bucket" "media_bucket" {
  bucket = "mern-media-joud-2025"
  tags = { Name = "Media Bucket" }
}

