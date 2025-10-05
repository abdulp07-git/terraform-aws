resource "aws_route_table" "main" {
  vpc_id = var.vpc-id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw-id
  }

  tags = {
    Name = var.tag
  }
}
