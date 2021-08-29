output "my_iam_user_complete_details" {
  value = aws_iam_user.my_iam_user
}

output "my_s3_bucket_complete_details" {
  value = aws_s3_bucket.my_s3_bucket
}

output "aws_security_group_http_server_details" {
  value = aws_security_group.http_server_security_group
}

output "aws_instance_details" {
  value = aws_instance.http_server
}

output "aws_instance_public_dns" {
  value = aws_instance.http_server.public_dns
}

output "aws_default_vpc" {
  value = aws_default_vpc.default
}
