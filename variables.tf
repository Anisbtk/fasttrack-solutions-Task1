variable "region" {
  description = "The AWS region to deploy in"
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "instance_type" {
  description = "The EC2 instance type"
  default     = "t3.micro"
}
