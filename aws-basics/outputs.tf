output "aws_security_group_http_server_details" {
  value = aws_security_group.http_server_security_group
}

output "aws_instance_details" {
  value = aws_instance.http_servers
}

output "aws_instance_public_dns" {
  value = values(aws_instance.http_servers).*.id
}

output "aws_default_vpc" {
  value = aws_default_vpc.default
}

output "elb_public_dns" {
  value = aws_elb.elb
}
