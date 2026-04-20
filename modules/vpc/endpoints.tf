resource "aws_vpc_endpoint" "interface" {
  for_each            = toset(var.interface_services)
  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.${var.region}.${each.value}"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = aws_subnet.private[*].id
  security_group_ids  = [aws_security_group.vpc_endpoint.id]
  private_dns_enabled = true

  tags = merge(var.common_tags, {
    Name = "${var.app_name}-${var.env}-${each.value}-endpoint"
  })
}

resource "aws_vpc_endpoint" "gateway" {
  for_each          = toset(var.gateway_services)
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${var.region}.${each.value}"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.private.id]

  tags = merge(var.common_tags, {
    Name = "${var.app_name}-${var.env}-${each.value}-endpoint"
  })
}