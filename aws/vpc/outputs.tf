output "public-instance-url" {
    value = "http://${aws_instance.public-instance.public_ip}"
}
output "private-instance-url" {
    value = "http://${aws_instance.private-instance.private_ip}"
}