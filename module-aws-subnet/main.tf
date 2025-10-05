resource "aws_subnet" "main" {
  for_each = var.subnet-map

  vpc_id = var.vpc-id
  cidr_block = each.value.cidr-block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip
  tags = merge(each.value.tags,
  {
    Name = "${var.tag}-${each.key}"
  }
  )
}

resource "aws_route_table_association" "main" {
  for_each = var.subnet-map

  subnet_id      = aws_subnet.main[each.key].id
  route_table_id = each.value.is_public ? var.public-route-id  : var.private-route-id 
}
