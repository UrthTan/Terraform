# AWS EC2 Instance Terraform Variables
# EC2 Instance Variables

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t3.micro"
}

# Key Pair
variable "aws_key_pair" {
  default = "~/Desktop/personal-files/default-ec2.pem"
}

# Key Pair Name
variable "aws_key_pair_name" {
  description = "Key Pair Name"
  type        = string
  default     = "default-ec2"
}

# AWS EC2 Private Instance Count
variable "private_instance_count" {
  description = "AWS EC2 Private Instances Count"
  type        = number
  default     = 2
}