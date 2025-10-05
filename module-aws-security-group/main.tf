resource "aws_security_group" "main" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc-id

  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )
}

# Ingress Rules
resource "aws_security_group_rule" "ingress" {
  for_each = { for idx, rule in var.ingress-rules : idx => rule }

  type              = "ingress"
  description       = each.value.description
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  security_group_id = aws_security_group.main.id

  # Use cidr_blocks OR source_security_group_id (not both)
  cidr_blocks              = each.value.cidr_blocks
  source_security_group_id = each.value.source_security_group_id
}

# Egress Rules
resource "aws_security_group_rule" "egress" {
  for_each = { for idx, rule in var.egress-rules : idx => rule }

  type              = "egress"
  description       = each.value.description
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  security_group_id = aws_security_group.main.id

  # Use cidr_blocks OR destination_security_group_id (not both)
  cidr_blocks                   = each.value.cidr_blocks
  #destination_security_group_id = each.value.destination_security_group_id
}
