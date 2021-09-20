output "my_iam_user_complete_details" {
  value = aws_iam_user.my_iam_user
}

output "backend_bucket_complete_details" {
  value = aws_s3_bucket.backend_state
}
