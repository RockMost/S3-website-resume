# Define the S3 bucket with website configuration
resource "aws_s3_bucket" "iamrodneypowell" {}


resource "aws_s3_bucket_website_configuration" "iamrodneypowell" {
  bucket = aws_s3_bucket.iamrodneypowell.bucket

  # Configure website hosting with index document
   index_document {
    suffix = "Resume.html" 
  }
}

# Upload the Resume.html file to the S3 bucket
resource "aws_s3_object" "Resume" {
  bucket = aws_s3_bucket.iamrodneypowell.bucket
  key    = "Resume.html"
  source = "/Users/rodneyp-edu/Desktop/Terraform import/Resume.html"  # Update with the correct file path

  content_type = "text/html"
}

# Define the bucket policy to allow public read access to objects
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.iamrodneypowell.bucket

  policy = jsonencode({
    Statement = [
      {
        Action    = "s3:GetObject"
        Effect    = "Allow"
        Principal = "*"
        Resource  = "${aws_s3_bucket.iamrodneypowell.arn}/*"
        Sid       = "PublicReadGetObject"
      },
    ]
    Version = "2012-10-17"
  })
}

# Define server-side encryption configuration for the bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.iamrodneypowell.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
