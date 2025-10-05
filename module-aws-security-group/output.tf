output "sg-id" {
  value       = aws_security_group.main.id
  description = "Security group ID"
}

output "sg-name" {
  value       = aws_security_group.main.name
  description = "Security group name"
}

output "sg-arn" {
  value       = aws_security_group.main.arn
  description = "Security group ARN"
}
