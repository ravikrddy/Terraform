variable "aws_region" {
  default = "us-east-1"
}

variable "ami" {
  default = "ami-04b9e92b5572fa0d1"
  //default = "ami-09f2114fecbe506e2"
}

variable "instance_count" {
  default = "1"
}

variable "instance_type" {
  default = "t2.nano"
}

variable "key_name" {
  default = "awskey"
}