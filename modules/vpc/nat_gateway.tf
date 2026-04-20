resource "aws_eip" "nat" {
  count  = var.is_nat_gateway ? 1 : 0
  domain = "vpc"

  tags = merge(var.common_tags, {
    Name = "${var.app_name}-${var.env}-nat-eip"
  })
}

resource "aws_nat_gateway" "this" {
  count         = var.is_nat_gateway ? 1 : 0
  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(var.common_tags, {
    Name = "${var.app_name}-${var.env}-nat-gw"
  })

  # Specify dependencies so that it is created after IGW is available
  depends_on = [aws_internet_gateway.this]
}

resource "aws_route" "private_nat_gateway" {
  count                  = var.is_nat_gateway ? 1 : 0
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[0].id
}