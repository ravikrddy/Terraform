variable "aws_region" {
  default = "us-east-1"
}

variable "subnets" {
  type = "list"

  default = ["subnet-02ec5c5f","subnet-0fcfd503","subnet-1d960522","subnet-26daa16d","subnet-3d502a59","subnet-bb04b894"]
}

variable "ami" {
  default = "ami-08bc77a2c7eb2b1da"
}

variable "instance_count" {
  default = "2"
}

variable "instance_type" {
  default = "t2.nano"
}

variable "key_name" {
  default = "awskey"
}