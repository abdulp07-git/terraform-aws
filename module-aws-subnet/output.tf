
output "subnet-ids" {
  value       = { for k, v in aws_subnet.main : k => v.id }
  description = "Map of subnet names to subnet IDs"
}
