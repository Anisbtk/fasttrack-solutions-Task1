variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "ec2_security_groups" {
  description = "List of EC2 security group IDs"
  type        = list(string)
}
