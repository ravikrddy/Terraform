 output "efs-dns" {
    value = "${aws_efs_file_system.efs.id}.efs.${var.aws_region}.amazonaws.com"
}