resource "aws_route_table" "main" {
  vpc_id = var.vpc-id

  tags = {
    Name = var.tag
  }
}
