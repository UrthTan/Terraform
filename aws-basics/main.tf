terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# default_vpc > terraform will not destroy or create aws_default_vpc but instead adopt
resource "aws_default_vpc" "default" {

}

# Get subnet
data "aws_subnet_ids" "default_subnets" {
  vpc_id = aws_default_vpc.default.id
}

# Get ami, expect only 1 result
data "aws_ami" "aws_linux_2_latest" {
  owners      = ["amazon"]
  most_recent = true
  filter { # filter down
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

# Security Group
resource "aws_security_group" "http_server_security_group" {
  name   = "http_server_security_group"
  vpc_id = aws_default_vpc.default.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "http_server_security_group"
  }
}

resource "aws_security_group" "elb_sg" {
  name   = "elb_sg"
  vpc_id = aws_default_vpc.default.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elb" "elb" {
  name            = "elb"
  subnets         = data.aws_subnet_ids.default_subnets.ids
  security_groups = [aws_security_group.elb_sg.id]
  instances       = values(aws_instance.http_servers).*.id
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}

resource "aws_instance" "http_servers" {
  ami                    = data.aws_ami.aws_linux_2_latest.id
  key_name               = "default-ec2"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.http_server_security_group.id]
  for_each               = data.aws_subnet_ids.default_subnets.ids
  subnet_id              = each.value
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user" # by default
    private_key = file(var.aws_key_pair)
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",                                                                                    # install httpd
      "sudo service httpd start",                                                                                     # start
      "echo Provisioned with Terraform - Virtual Server is at ${self.public_dns} | sudo tee /var/www/html/index.html" # copy a file
    ]
  }
  tags = {
    name : "http_servers_${each.value}"
  }
}