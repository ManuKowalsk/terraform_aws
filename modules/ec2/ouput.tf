output "aws_instance" {
  value = aws_instance.web[*].id
}