# vpcs
resource "aws_vpc" "vpcs" {
  count = length(var.vpcs)
  cidr_block = var.vpcs[count.index]
  tags = {
    Name = var.vpcs_tags[count.index]
  }
}
//resource "aws_vpc" "vpc_test" {
//  cidr_block = var.vpc_test["cidr_block"]
//  tags = {
//    Name = var.vpc_test["Name"]
//  }
//}

#subnets
resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets)
  cidr_block = var.public_subnets[count.index]
  tags = {
    Name = var.public_subnets_tags[count.index]
  }
  vpc_id = aws_vpc.vpcs.*.id[0]
  availability_zone = var.availible_zone[count.index % length(var.availible_zone)]
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnets)
  cidr_block = var.private_subnets[count.index]
  tags = {
    Name = var.private_subnets_tags[count.index]
  }
  vpc_id = aws_vpc.vpcs.*.id[0]
  availability_zone = var.availible_zone[count.index % length(var.availible_zone)]
}

resource "aws_subnet" "rds_private_subnets" {
  count = length(var.rds_private_subnets)
  cidr_block = var.rds_private_subnets[count.index]
  tags = {
    Name = var.rds_private_subnets_tags[count.index]
  }
  vpc_id = aws_vpc.vpcs.*.id[0]
  availability_zone = var.availible_zone[count.index % length(var.availible_zone)]
}

#internet gateways
resource "aws_internet_gateway" "internet_gateways" {
  vpc_id = aws_vpc.vpcs.*.id[0]
  tags = {
    Name = var.internet_gateways_tags[0]
  }
}

#nat gateways
resource "aws_nat_gateway" "nat_gateways" {
  count = length(var.eip_nat_gateways_tags)
  allocation_id = aws_eip.nat_gateways_eip.*.id[count.index]
  subnet_id     = aws_subnet.public_subnets.*.id[count.index]
  tags = {
    Name = var.nat_gateways_tags[count.index]
  }
  depends_on = [aws_eip.nat_gateways_eip]
}

#route tables
resource "aws_route_table" "public_route_tables" {
  count=length(var.public_route_tables_tags)
  vpc_id = aws_vpc.vpcs.*.id[0]
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateways.*.id[0]
  }
  tags = {
    Name = var.public_route_tables_tags[count.index]
  }
  depends_on = [aws_internet_gateway.internet_gateways]
}
resource "aws_route_table_association" "public_rtb" {
  count = length(aws_subnet.public_subnets)
  subnet_id = aws_subnet.public_subnets.*.id[count.index]
  route_table_id = aws_route_table.public_route_tables.*.id[0]
  depends_on = [aws_subnet.public_subnets,aws_route_table.public_route_tables]
}

resource "aws_route_table" "private_route_tables" {
  count=length(var.private_route_tables_tags)
  vpc_id = aws_vpc.vpcs.*.id[0]
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateways.*.id[0]
  }
//  route {
//    cidr_block = "0.0.0.0/0"
//    gateway_id = aws_internet_gateway.internet_gateways.*.id[0]
//  }
  tags = {
    Name = var.private_route_tables_tags[count.index]
  }
  depends_on = [aws_nat_gateway.nat_gateways]
}
resource "aws_route_table_association" "private_rtb" {
  count = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets.*.id[count.index]
  route_table_id = aws_route_table.private_route_tables.*.id[0]
  depends_on = [aws_subnet.private_subnets,aws_route_table.private_route_tables]
}

resource "aws_route_table" "rds_private_route_tables" {
  count=length(var.rds_private_route_tables_tags)
  vpc_id = aws_vpc.vpcs.*.id[0]
  tags = {
    Name = var.rds_private_route_tables_tags[count.index]
  }
  depends_on = [aws_subnet.rds_private_subnets]
}
resource "aws_route_table_association" "rds_private_rtb" {
  count = length(aws_subnet.rds_private_subnets)
  subnet_id      = aws_subnet.rds_private_subnets.*.id[count.index]
  route_table_id = aws_route_table.rds_private_route_tables.*.id[0]
  depends_on = [aws_route_table.rds_private_route_tables]
}