provider "aws" {
  region = "${var.aws_region}"
}
resource "aws_security_group" "allow_http" {
  name = "allow_http"
  description = "Allow HTTP traffic"
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
  # ingress {
  #   from_port = 3389
  #   to_port = 3389
  #   protocol = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
}

resource "aws_instance" "web-server" {
  ami              = "${var.ami}"
  instance_type    = "${var.instance_type}"
  key_name         = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow_http.id}"]
  user_data        = "${file("files/web_bootstrap.sh")}"
  
  tags = {
    Name = "web-server"
  }
}

resource "aws_ebs_volume" "data-volume" {
  availability_zone = "${aws_instance.web-server.availability_zone}"
  size              = 2

  tags = {
    Name = "data-volume"
  }
}

resource "aws_volume_attachment" "ebs_attach" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.data-volume.id}"
  instance_id = "${aws_instance.web-server.id}"
}

resource "aws_ebs_snapshot" "ebs_snapshot" {
  volume_id = "${aws_ebs_volume.data-volume.id}"

  tags = {
    Name = "data-volume-snap"
  }
}

# resource "aws_ebs_volume" "data-volume-resize" {
#   availability_zone = "${aws_instance.web-server.availability_zone}"
#   size              = 3

#   tags = {
#     Name = "data-volume"
#   }
# }

# resource "aws_ami_from_instance" "web-server-ami" {
#   name               = "web-server-ami"
#   source_instance_id = "${aws_instance.web-server.id}"
# }