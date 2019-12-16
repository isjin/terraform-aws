#bucket
##jtp_training bucket
resource "aws_s3_bucket" "jtp_training" {
  bucket = "jtp.training"
  acl = "private"
  versioning {
    enabled = true
  }
  tags = {
    Name = "jtp_training"
  }
}

