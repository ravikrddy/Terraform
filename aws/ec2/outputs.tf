output "web-server-url" {
    value = "http://${aws_instance.web-server.public_ip}"
}