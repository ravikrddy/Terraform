provider "aws" {
  region = "${var.aws_region}"
}
resource "aws_security_group" "efs" {
  name = "efs"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 2049
    to_port = 2049
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 2049
    to_port   = 2049
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
     from_port = 0
     to_port = 0
     protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
   }
}

resource "aws_efs_file_system" "efs" {
  tags = {
    Name = "efs"
  }
 }

# data "template_file" "init" {
#   template = "${file("files/web_bootstrap.sh")}"

#   vars = {
#     efs_id = "${aws_efs_file_system.efs.id}"
#     region = "${var.aws_region}"
#   }
# }

 resource "aws_efs_mount_target" "efs-mount" {
  count           = "${length(var.subnets)}"
  file_system_id = "${aws_efs_file_system.efs.id}"
  subnet_id      = "${element(var.subnets, count.index)}"

  security_groups = [
    "${aws_security_group.efs.id}",
  ]
}

resource "aws_instance" "ubuntu" {
  count            = "${var.instance_count}"
  ami              = "${var.ami}"
  instance_type    = "${var.instance_type}"
  key_name         = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.efs.id}"]
  #user_data        = "${data.template_file.init.rendered}"
  user_data        = "${file("files/web_bootstrap.sh")}"
  
  tags = {
    Name = "ubuntu-${count.index + 1}"
  }
}