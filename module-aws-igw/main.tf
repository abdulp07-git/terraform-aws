resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc-id
  tags = {
    Name = var.tag
  }
}
