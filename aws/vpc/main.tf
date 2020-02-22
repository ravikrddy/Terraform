provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_vpc" "custom-vpc" {
    cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "public-subnet" {
    vpc_id = "${aws_vpc.custom-vpc.id}"
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
}
resource "aws_subnet" "private-subnet" {
    vpc_id = "${aws_vpc.custom-vpc.id}"
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
}
resource "aws_internet_gateway" "custom-igw" {
    vpc_id = "${aws_vpc.custom-vpc.id}"
}
resource "aws_eip" "custom-elastic-ip" {
    vpc = true
}
resource "aws_nat_gateway" "custom-ngw" {
  allocation_id = "${aws_eip.custom-elastic-ip.id}"
  subnet_id     = "${aws_subnet.public-subnet.id}"
}

resource "aws_route_table" "public-rt" {
    vpc_id = "${aws_vpc.custom-vpc.id}"
    
    route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = "${aws_internet_gateway.custom-igw.id}" 
    }
}

resource "aws_route_table_association" "public-subnet-rt"{
    subnet_id = "${aws_subnet.public-subnet.id}"
    route_table_id = "${aws_route_table.public-rt.id}"
}

resource "aws_route_table" "private-rt" {
    vpc_id = "${aws_vpc.custom-vpc.id}"
    
    route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = "${aws_nat_gateway.custom-ngw.id}" 
    }
}
resource "aws_route_table_association" "private-subnet-rt"{
    subnet_id = "${aws_subnet.private-subnet.id}"
    route_table_id = "${aws_route_table.private-rt.id}"
}

resource "aws_security_group" "allow_http" {
  name = "allow_http"
  description = "Allow HTTP traffic"
  vpc_id      = "${aws_vpc.custom-vpc.id}"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
     from_port = 0
     to_port = 0
     protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
   }
}
resource "aws_instance" "public-instance" {
  ami              = "${var.ami}"
  instance_type    = "${var.instance_type}"
  key_name         = "${var.key_name}"
  subnet_id = "${aws_subnet.public-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.allow_http.id}"]
  user_data        = "${file("files/web_bootstrap.sh")}"
  
  tags = {
    Name = "public-instance"
  }
}

resource "aws_instance" "private-instance" {
  ami              = "${var.ami}"
  instance_type    = "${var.instance_type}"
  key_name         = "${var.key_name}"
  subnet_id = "${aws_subnet.private-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.allow_http.id}"]
  user_data        = "${file("files/web_bootstrap.sh")}"
  
  tags = {
    Name = "private-instance"
  }
}