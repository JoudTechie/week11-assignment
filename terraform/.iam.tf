resource "aws_iam_user" "s3_media_user" {
  name = "media-upload-user-v2"
}

resource "aws_iam_policy" "media_s3_policy" {
  name        = "MediaS3AccessPolicy-v2"
  description = "Allows access to S3 media bucket"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action   = ["s3:PutObject", "s3:GetObject"],
      Effect   = "Allow",
      Resource = "arn:aws:s3:::mern-media-joud-2025/*"
    }]
  })
}

resource "aws_iam_user_policy_attachment" "attach_media_policy" {
  user       = aws_iam_user.s3_media_user.name
  policy_arn = aws_iam_policy.media_s3_policy.arn
}

resource "aws_iam_access_key" "media_user_key" {
  user = aws_iam_user.s3_media_user.name
}
